# Run iipsrv in a Docker container

In order to build this image server, a licensed version of Kakadu needs to be
included in the source code. That has been excluded from this repository due
to licensing constraints.

Obtain the latest Kakadu SDK package and uncompress it in a new `kakadu/`
folder under this location.

In order to enable HTJ2K decoding, some modifications to the source must be
made. These are documented in the "Enabling_HT.txt" document in the Kakadu
package, and for our purpose can be boiled down to the following:

- Uncomment the following line near the top of "fbc_common.h" within the
  "coresys/fast_coding" sub-directory: `#define FBC_ENABLED`
- Ensure that the `FBC_NO_ACCELERATION` line below `FBC_ENABLED` is commented
  out.
- Rename the `srclib_ht` directory in your Kakadu distribution
  and replace it with a copy of `altlib_ht_opt`.  For example:

  ```
  mv srclib_ht srclib_ht_noopt; cp -r altlib_ht_opt srclib_ht
  ```

Then, move on to building the container:

```
docker build -t iipsrv_htj2k:latest .
```

The container can be run with the OpenJPEG or Kakadu engine. For OpenJPEG,
binding the container's default image directory to your host's:

```
docker run -p 8000:8000 -v ~/images:/data/images iipsrv_htj2k:latest
```

For Kakadu:

```
docker run -e "IIPSRV_ENGINE=kakadu" -p 8000:8000 -v ~/images:/data/images iipsrv_htj2k:latest
```

Test the server:

```
curl -i localhost:8000/iiif/<image ID>/info.json
```

Where `<image ID>` is the path to the image file, relative to the
directory you mounted in the `run` command.
