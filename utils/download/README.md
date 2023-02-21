# imagelist.py


This script downloads a list of images provided by a txt file from the example Getty images stored in Google Drive. 

To run the command you first need to download credentials from Google by registering a new Google Drive project at:

https://developers.google.com/workspace/guides/create-project

Download the credentials and store it in the download directory and call it `credentials.json`. 

Run the command as follows:

```
python imagelist.py ../data/50_images/image_list.txt ../imgs/50/original/
```

Where:
 * `../data/50_images/image_list.txt` is the list of image filenames to download
 * `../imgs/50/original/`` is the location to download the tif files.


An example of the image list is below:

```
gm_36716601.tif
gm_36717601.tif
gm_36717701.tif
gm_36717901.tif
gm_37049301.tif
gm_37199501.tif
gri_2001_pr_2_001_mm.tif
gri_2003_r_22_b008_007_mm.tif
gri_2011_m_34_001_pm.tif
gri_2012_pr_71_pm.tif
gri_2014_pr_24_001_mm.tif
```
