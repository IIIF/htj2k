# Run iipsrv in a Docker container

Build the container:

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
