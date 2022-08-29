import random

from os import environ, path

from locust import HttpUser, SequentialTaskSet, constant, task

__doc__ = """
Locustfile to load-test IIIF implementation.

This file is to be used with Locust (run ``pip install -r requirements.txt`` in
the main project folder to pull the dependencies). It assumes three files with
lists of images divided by size ranges to be present in the ``data`` folder.
These files can be obtained with the python sctipts in the ``analyze`` folder
and, of course, assume the presence of a local file list that matches the files
in the IIIF server being load-tested.

"""


BASEDIR = path.dirname(path.dirname(path.realpath(__file__)))
DATAFILE = path.join(BASEDIR, 'data', 'ruven_set.txt')
DATASET = environ["LOCUST_IMG_DATASET"]
FMT = environ["LOCUST_IMG_FORMAT"]

# Default source size range. Either a number (0 or greater, indicating the
# range number) or ``None``, in which case a random range is chosen each time.
# Override this with the ``LOCUST_SRC_SZ_RNG`` environment variable.
DEFAULT_SRC_SZ_RNG = None
# Default derivative size. One of ``full`, ``large``, ``thumb`` or None.
# None requests all three sizes for each source image chosen by the HTTP
# client. Override this with the ``LOCUST_DERV_SZ`` environment variable.
DEFAULT_DERV_SZ = None

IIIF_URL_PTN = (
        f"/iiif/{DATASET}/{{id}}.{FMT}/{{reg_str}}/"
        f"{{size_str}}/0/default.jpg")


class Derivatives(SequentialTaskSet):
    """
    Request different sorts of derivatives for one image source.

    This class picks ONE image identifier and requests a constant number of
    full-size, large, random area and thumbnail derivatives.
    """
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Index of image list.

    @task
    def deriv_large(self):
        self._request_derivative(4096)

    @task
    def deriv_med(self):
        self._request_derivative(1024)

    @task
    def deriv_thumb(self):
        self._request_derivative(128)

    @task
    def deriv_rnd_region(self):
        self._request_derivative(
                512, (random.randint(0, 1024), random.randint(0, 1024)),
                "rnd_region")

    @task
    def deriv_aligned_tile(self):
        # Align random coordinates to a 512*512 grid.
        x = random.randint(0, 4096 + 512 - 1)
        x -= x % 512
        y = random.randint(0, 4096 + 512 - 1)
        y -= y % 512
        self._request_derivative(512, (x, y), "tile")

    @task
    def stop(self):
        print(f"Index: {self.parent.i}")
        self.parent.i += 1
        self.parent.interrupt(True)

    def _request_derivative(self, size, region=None, reg_type=None):
        """
        Request a IIIF derivative based on size and optional cropped area.

        :param int size: number of pixels for the maximum width or height.

        :param tuple region: tuple of 2 integers representing x and y
            coordinates, or ``None``. The ``size`` parameter is used for the
            tile size if this parameter is not ``None``.
        """
        if region is None:
            reg_str = 'full'
            size_str = size if size == 'full' else f'!{size},{size}'
            # Statistics are grouped by this string.
            stats_name = f'{{derv_sz: {size}}}'
        else:
            reg_str = f'{region[0]},{region[1]},{size},{size}'
            size_str = 'full'
            stats_name = f'{{derv_sz: "{reg_type}"}}'

        id = self.parent.ids[self.parent.i]
        url_str = IIIF_URL_PTN.format(
            id=id,
            reg_str=reg_str,
            size_str=size_str
        )
        self.client.get(url_str, name=stats_name)


class IIIFSwarmer(HttpUser):
    """
    Locust class.
    """
    i = 0

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        with open(DATAFILE, 'r') as fh:
            self.ids = fh.read().splitlines()

    tasks = [Derivatives]
    wait_time = constant(0.)
