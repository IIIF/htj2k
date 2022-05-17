# Run iipsrv in a Docker container

Build the container:

```
docker build -t iipsrv:latest .
```

Run it binding the container's default image directory to your host's:

```
docker run -p 8000:8000 -p 8001:8001 -v ~/images:/data/images iipsrv:latest
```

Test server:

```
curl localhost:<port #>/iiif/<image ID>/info.json
```

Where `<port #>` is 8000 for the iipsrv instance supporting OpenJPEG, and 8001
for Kakadu; and `<image ID>` is the path to the image file, relative to the
directory you mounted in the `run` command.
