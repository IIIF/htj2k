# htj2k

A project to evaluate htj2k for IIIF.

Follow setup instructions below and then specific instructions for running the
conversion and benchmarks in the individual subfolders.

## Setup Instructions (*nix)

Install [LibVIPS](https://www.libvips.org/install.html) and
[Kakadu](https://kakadusoftware.com/documentation-downloads/downloads/) in
your operating system.

Create a project folder:

```
mkdir htj2k
```

Create Python virtual environment:

```
cd htj2k
python3 -m venv venv
source venv/bin/activate
```

Clone this repo:

```
git clone git@github.com:IIIF/htj2k.git src
```

Install dependencies:

```
cd src
pip install -r requirements.txt
```
