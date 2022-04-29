# Run iipsrv in a Docker container

Build the container:

```
docker build -t iipsrv:latest .
```

Run it binding the container's default image directory to your host's:

```
docker run -p 8888:80 -v ~/images:/data/images iipsrv:latest
```

Test server:

```
curl localhost:8888/iiif/<image ID>/info.json
```

Where `<image ID>` is the path to the image file, relative to the directory you
mounted in the `run` command.
