package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._
import scala.math._
import scala.collection.mutable.ListBuffer

import io.circe._, io.circe.parser._, io.circe.generic.semiauto._

class IIIFTiles extends Simulation {

  private def getProperty(propertyName: String, defaultValue: String) = {
    Option(System.getenv(propertyName))
      .orElse(Option(System.getProperty(propertyName)))
      .getOrElse(defaultValue)
  }

  def baseUrl: String = getProperty("baseUrl", "http://localhost/iiif/images/")

  object Tiles {

    sealed trait InfoJson
    case class TileSet(width: Int, height: Option[Int], scaleFactors: List[Int])
        extends InfoJson
    implicit val decoder: Decoder[TileSet] = deriveDecoder[TileSet]

    val image_feeder = csv("images.csv").random
    val fetch_infos = exec(
      feed(image_feeder)
        .exec(
          http("Info JSON")
            .get("${ID}/info.json")
            .header(
              "accept",
              "application/ld+json; profile=\"http://iiif.io/api/image/3/context.json\""
            )
            .check(status.is(200))
            .check(
              jsonPath("$.width").ofType[Int].saveAs("width"),
              jsonPath("$.height").ofType[Int].saveAs("height")
            )
            .check(
              jmesPath("tiles")
                .transform(t =>
                  parser.decode[List[TileSet]](t).getOrElse(Json.Null)
                )
                .saveAs("tiles")
            )
        )
    )

    val simulate_zoom_4 = foreach("${tiles}", "t") {
      exec((s: Session) => {
        val tile_set = s("t").as[TileSet]
        val tile_width = tile_set.width
        s.set("tile_set", tile_set)

      }).repeat("${tile_set.scaleFactors.size()}", "i") {
        exec((s: Session) => {
          val i = s("i").as[Int]
          val tile_set = s("tile_set").as[TileSet]
          val width = s("width").as[Int]
          val height = s("height").as[Int]
          val scale = tile_set.scaleFactors(i)
          val regionWidth = scale * tile_set.width;
          val regionHeight = scale * tile_set.height.getOrElse(tile_set.width);

          val scaleWidth = ceil(width / scale);
          val scaleHeight = ceil(height / scale);
          var tile_requests = s.contains("tile_requests") match {
            case true =>
              s("tile_requests")
                .as[List[String]]
                .to(collection.mutable.ListBuffer)
            case false => new ListBuffer[String]()
          }

          var y = 0;
          while (y < height) {
            var x = 0;
            while (x < width) {
              var region = "";
              if (
                scaleWidth <= tile_set.width && scaleHeight <= tile_set.height
                  .getOrElse(tile_set.width)
              ) {
                region = "full";
              } else {
                var rw = min(regionWidth, width - x);
                var rh = min(regionHeight, height - y);
                region = x + "," + y + "," + rw + "," + rh;
              }
              var scaledWidthRemaining = ceil((width - x) / scale);
              var tw = min(tile_set.width, scaledWidthRemaining);
              val iiifArgs = "/" + region + "/" + tw + ",";
              tile_requests += iiifArgs
              x += regionWidth;
            }
            y += regionHeight;
          }
          s.set("tile_requests", tile_requests.toList)
        })
      }.foreach("${tile_requests}", "request_url") {
        exec(http("Tile Request").get("${ID}/${request_url}/0/default.jpg"))
      }
    }

    def calculateRegionAndSize(
        width: Int,
        height: Int,
        s: Int,
        tw: Int,
        th: Int,
        n: Int,
        m: Int
    ): (Int, Int, Int, Int, Int, Int) = {
      val xr = n * tw * s;
      val yr = m * th * s;
      val wr = if (xr + tw * s > width) width - xr else tw * s;
      val hr = if (yr + th * s > height) height - yr else th * s;
      val ws = if (xr + tw * s > width) (width - xr + s - 1) / s else tw;
      val hs = if (yr + th * s > height) (height - yr + s - 1) / s else th;
      (xr, yr, wr, hr, ws, hs)
    }

  }
  before {
    println(s"running with:")
    println(
      s"baseUrl: ${getProperty("baseUrl", "http://localhost/image/iiif/")}"
    )
  }
  val httpConf = http
    .baseUrl(baseUrl)
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("PerfTesting")

  var tiles = scenario("Tiles")
    .exec(Tiles.fetch_infos)
    .exec(Tiles.simulate_zoom_4)

  setUp(
    tiles.inject(rampUsers(1) during (40.seconds))
  ).protocols(httpConf)

}
