import random

from os import path
from glob import glob

from locust import HttpUser, TaskSet, between, task

__doc__ = """
Locustfile to load-test IIIF implementation.

This file is to be used with Locust (run ``pip install -r requirements.txt`` in
the main project folder to pull the dependencies). It assumes three files with
lists of images divided by size ranges to be present in the ``data`` folder.
These files can be obtained with the python sctipts in the ``analyze`` folder
and, of course, assume the presence of a local file list that matches the files
in the IIIF server being load-tested.

"""


BASEDIR = path.dirname(path.realpath(__file__))
DATA_DIR = path.join(BASEDIR, 'data')
# This should guarantee that the ranges are ordered by size.
IDX_FNAMES = sorted(glob(path.join(DATA_DIR, 'imgmeta_range_*')))

# Default source size range. Either a number (0 or greater, indicating the
# range number) or ``None``, in which case a random range is chosen each time.
# Override this with the ``LOCUST_SRC_SZ_RNG`` environment variable.
DEFAULT_SRC_SZ_RNG = None
# Default derivative size. One of ``full`, ``large``, ``thumb`` or None.
# None requests all three sizes for each source image chosen by the HTTP
# client. Override this with the ``LOCUST_DERV_SZ`` environment variable.
DEFAULT_DERV_SZ = None

IIIF_URL_PTN = '/iiif/image/{id}/{reg_str}/{size_str}/0/default.jpg'


class Derivatives(TaskSet):
    """
    Request different sorts of derivatives for one image source.

    This class picks ONE image identifier and requests a constant number of
    full-size, large, random area and thumbnail derivatives.
    """

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.id = random.choice(self.parent.ids)

    @task(1)
    def deriv_large(self):
        self._request_derivative(4096)

    @task(4)
    def deriv_med(self):
        self._request_derivative(1024)

    @task(10)
    def deriv_thumb(self):
        self._request_derivative(128)

    @task(10)
    def deriv_area(self):
        self._request_derivative(
                512, (random.randint(0, 1024), random.randint(0, 1024)))

    @task(1)
    def stop(self):
        self.interrupt()

    def _request_derivative(self, size, region=None):
        """
        Request a IIIF derivative based on size and optional cropped area.

        :param int size: number of pixels for the maximum width or height.

        :param tuple region: tuple of 2 integers representing x and y
            coordinates, or ``None``. The ``size`` parameter is used for the
            tile size if this parameter is not ``None``.
        """
        src_list_name = path.splitext(path.basename(self.parent.source))[0]
        ranges = src_list_name.lstrip('imgmeta_range_').split('-')
        lrange = ranges[0] or 0
        hrange = ranges[1] or None
        if region is None:
            reg_str = 'full'
            size_str = size if size == 'full' else f'!{size},{size}'
            # Statistics are grouped by this string.
            stats_name = (
                    f'{{lrange: {lrange}, hrange: {hrange}, derv_sz: {size}}}')
        else:
            reg_str = f'{region[0]},{region[1]},{size},{size}'
            size_str = 'full'
            stats_name = (
                    f'{{lrange: {lrange}, hrange: {hrange}, derv_sz: "tile"}}')

        url_str = IIIF_URL_PTN.format(
            id=self.id,
            reg_str=reg_str,
            size_str=size_str
        )
        self.client.get(url_str, name=stats_name)


class Sources(TaskSet):
    """
    Sources task set.

    Responsible for choosing a list of images from which its sub-task,
    ``Derivatives``, chooses random images to request.
    """

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.source = IDX_FNAMES[random.randint(0, 2)]
        with open(self.source, 'r') as fh:
            self.ids = fh.read().splitlines()

    tasks = {Derivatives: 10}


class IIIFSwarmer(HttpUser):
    """
    Locust class.
    """
    tasks = {Sources: 1}
    wait_time = between(0.5, 1)
