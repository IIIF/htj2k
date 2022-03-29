#!/usr/bin/env python3

import logging

from io import BytesIO
from os import path
from sys import argv

import pyvips as vips

from pyvips.enums import Interpretation as chmode, Intent

here = path.dirname(path.realpath(__file__))
SRGB_PROFILE_FPATH = path.join(here, "sRGB2014.icc")
GRAY_PROFILE_FPATH = path.join(here, "generic_gray_gamma_2.2.icc")

logger = logging.getLogger(__name__)


class ImageValidationError(ValueError):
    """ Raised when an input image does not meet standards for conversion. """
    pass


class ImageConversionError(IOError):
    """ Raised when a non-TIFF image conversion error occurs. """
    pass


def image_to_ptiff(data, out_file, max_size=(None, None), auto_flatten=False):
    """
    Convert an image to a pyramidal TIFF using pyvips.

    Args:
        data (BytesIO): Streaming buffer to read from.

    Keyword Args:
        max_size (tuple): Tuple of maximum sizes (width, height) to contain
            the image in. If any of the sizes is ``None``, that dimension is
            not constrained. If any of them is 0, the function does not perforn
            any processing and returns ``None``.
        auto_flatten (bool): If set to ``True``, when an image with alpha is
            encountered, the channel will be discarded and the image flattened.
            If False (the default), an exception is raised in order to allow
            manual inspection and correction of the image.

    Returns:
        BytesIO: Byte buffer with pyramidal TIFF image contents.
    """
    vips.cache_set_max(0)

    max_w, max_h = max_size
    if max_w == 0 or max_h == 0:
        return None

    img = vips.Image.new_from_buffer(data.read(), "")

    channels = img.interpretation
    if channels not in (
        chmode.SRGB, chmode.RGB, chmode.RGB16, chmode.B_W, chmode.GREY16,
    ):
        raise ValueError(f"Color mode {channels} is not supported.")

    # Since only RGB and gray are supported, 4 bands means RGBA, 2 bands
    # means Gray + A.
    transp = img.bands == 4 or img.bands == 2
    if transp:
        if auto_flatten:
            logger.debug("Removing alpha channel.")
            img = img.flatten()
        # else:
        #     raise ImageValidationError(
        #         "Alpha channel detected. Not flattening automatically."
        #     )
    # Multi-page images may be OK—temporarily.
    # if img.get("n-pages") > 1:
    #    raise ImageValidationError(
    #        "Multi-layer or multi-page image detected. Multiple pages "
    #        "are not supported."
    #    )
    img = img.autorot()

    # Set the right ICC profile unconditionally.
    # TODO It may be unnecessary if the right profile is already embedded, if
    # we can know precisely. But also not a big deal.
    profile_fpath = (
        GRAY_PROFILE_FPATH if channels == chmode.B_W else SRGB_PROFILE_FPATH
    )
    logger.debug(f"Setting ICC profile: {profile_fpath}.")
    try:
        img = img.icc_transform(
            profile_fpath, embedded=True, intent=Intent.PERCEPTUAL
        )
    # NOTE: This catches ALL VIPS errors that may happen during icc_transform
    # and might not be related to the color profile itself.
    except vips.error.Error:
        img = img.icc_export(
            output_profile=profile_fpath, intent=Intent.PERCEPTUAL
        )

    # Resize image if required.
    if max_w is not None or max_h is not None:
        if max_h is None:
            scale = min(max_w / img.width, 1)
        elif max_w is None:
            scale = min(max_h / img.height, 1)
        else:
            scale = min(min(max_w / img.width, max_h / img.height), 1)

        logger.debug(f"Resizing image {scale}x (bbox: {max_w}, {max_h})")
        img = img.resize(scale)

    # Remove all fields except for XMP.
    for md_field in ("photoshop-data", "iptc-data", "ipct-data", "exif-data"):
        img.remove(md_field)

    # TODO Parametrize at least Q and tile size.
    kw = {
        "compression": "lzw" if transp else "jpeg",
        "Q": 90,
        "profile": profile_fpath,
        "tile": True,
        "tile_width": 256,
        "tile_height": 256,
        "pyramid": True,
        "bigtiff": True,
        # "region_shrink": "average",
    }

    return BytesIO(img.tiffsave(out_file, **kw))


if __name__ == "__main__":
    in_path = argv[1]
    out_path = argv[2]
    with open(in_path, "rb") as in_fh:
        image_to_ptiff(in_fh, out_path)
