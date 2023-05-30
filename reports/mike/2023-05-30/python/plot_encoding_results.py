import math 
import argparse
import glob
import os
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
    
#directory_with_csv_files_default = r'.\logs\2023-05-28-encoding'
directory_with_csv_files_default = ".\\logs\\2023-05-28-encoding"
#directory_with_csv_files_default = "./logs/2023-05-28-encoding"

parser = argparse.ArgumentParser(description="create encoding performance plots")
parser.add_argument("--input_directory", 
                      help="directory where input CSVs are located. default is --input_directory \"%s\"" % (directory_with_csv_files_default) )

args = parser.parse_args()

if( args.input_directory ) :
  input_directory = args.input_directory
  print("processed --input_directory ", input_directory )
else:
  input_directory = directory_with_csv_files_default
  print("--input_directory command line argument not provided, using default = ", input_directory )

search_path = os.path.join(input_directory, "*.csv")
search_results = glob.glob( search_path )

all_values_array = np.empty([len(search_results),3], dtype=object)

search_index = 0
lossless_index = 0
lossy_index = 0
output_directory_values_lossless = []
encode_time_in_seconds_values_lossless = []
compressed_size_in_bytes_values_lossless = []
output_directory_values_lossy = []
encode_time_in_seconds_values_lossy = []
compressed_size_in_bytes_values_lossy = []

for search_result in search_results:
  
  words = search_result.split('/')
  if( len(words) == 1 ):
    words = search_result.split('\\')
  filename = words[-1]
  print( filename )

  filename_tokens = filename.split('.')
  first_filename_token = filename_tokens[0]

  print( first_filename_token )

  # making data frame 
  data = pd.read_csv(search_result) 
  
  # iterating the columns
  #for col in data.columns:
  #  print(col)

  cols_to_add = ["output_directory","encode_time_in_seconds","compressed_size_in_bytes"]
  search_result_values_array = pd.read_csv(search_result, index_col=False, usecols=cols_to_add)[cols_to_add].sort_values(by=["output_directory"], ascending=True).to_numpy()

  output_directory_full = search_result_values_array[0][0]
  words = output_directory_full.split('/')
  if( len(words) == 1 ):
    words = output_directory_full.split('\\')
  output_directory_value = words[-1]
  encode_time_in_seconds_value = search_result_values_array[0][1]
  compressed_size_in_bytes_value = search_result_values_array[0][2]

  # all_values_array[search_index][0] = output_directory
  # all_values_array[search_index][1] = search_result_values_array[0][1]
  # all_values_array[search_index][2] = search_result_values_array[0][2]

  search_index = search_index + 1
  
  if( output_directory_value.find("lossless") >= 0):
    output_directory_values_lossless.append(output_directory_value)
    encode_time_in_seconds_values_lossless.append(encode_time_in_seconds_value)
    compressed_size_in_bytes_values_lossless.append(compressed_size_in_bytes_value)
    lossless_index = lossless_index + 1
  else:
    output_directory_values_lossy.append(output_directory_value)
    encode_time_in_seconds_values_lossy.append(encode_time_in_seconds_value)
    compressed_size_in_bytes_values_lossy.append(compressed_size_in_bytes_value)
    lossy_index = lossy_index + 1

# output_directory_values = all_values_array[:,0]
# encode_time_in_seconds_values = all_values_array[:,1]
# compressed_size_in_bytes_values = all_values_array[:,2]
# print(all_values_array)

# output_directory_values_sorted_indices = np.argsort(output_directory_values)
# output_directory_values = np.take_along_axis( output_directory_values, output_directory_values_sorted_indices, 0)
# encode_time_in_seconds_values = np.take_along_axis( encode_time_in_seconds_values, output_directory_values_sorted_indices, 0)
# compressed_size_in_bytes_values = np.take_along_axis( compressed_size_in_bytes_values, output_directory_values_sorted_indices, 0)

encode_time_in_seconds_max = max( 
  max(encode_time_in_seconds_values_lossless), 
  max(encode_time_in_seconds_values_lossy) )

compressed_size_in_bytes_max = max( 
  max(compressed_size_in_bytes_values_lossless), 
  max(compressed_size_in_bytes_values_lossy) )

# make encoding time plot
########################################################################
plt.figure()
ax = plt.subplot(211)
titles = list(output_directory_values_lossless)
values = []
colours = []
labels = list(titles)

for key in titles:
  if 'htj2k' in key:
    colours.append("#bf132d")
  elif 'ptiff' in key:
    colours.append('#827d7d')    
  else:
    colours.append("#2d3a75")

data = np.array(encode_time_in_seconds_values_lossless)
bars = plt.barh(range(len(data)), data, zorder=0, color=colours )
for i in range(len(labels)):
  plt.text(data[i] + 3, i, f"({data[i]:.2f})", va = 'center')

plt.grid(True, axis='x', linestyle='--', linewidth=0.5, zorder=3 )
plt.yticks(range(len(data)), output_directory_values_lossless)
plt.ylabel(None)
plt.title("Encoding Time for 50 IIIF images \n using AWS EC2 c5.4xlarge \n with EBS storage")
#plt.xlabel("Encoding Time (seconds)") 
ax.set_xlim(left = 0, right = encode_time_in_seconds_max) 

plt.tight_layout()

ax = plt.subplot(212)
titles = list(output_directory_values_lossy)
values = []
colours = []
labels = list(titles)

for key in titles:
  if 'htj2k' in key:
    colours.append("#bf132d")
  elif 'ptiff' in key:
    colours.append('#827d7d')    
  else:
    colours.append("#2d3a75")

data = np.array(encode_time_in_seconds_values_lossy)
bars = plt.barh(range(len(data)), data, zorder=0, color=colours )
for i in range(len(labels)):
  plt.text(data[i] + 3, i, f"({data[i]:.2f})", va = 'center')

plt.grid(True, axis='x', linestyle='--', linewidth=0.5, zorder=3 )
plt.yticks(range(len(data)), output_directory_values_lossy)
plt.ylabel(None)
plt.xlabel("Encoding Time (seconds)") 
ax.set_xlim(left = 0, right = encode_time_in_seconds_max) 

plt.tight_layout()

words = input_directory.split('/')
if( len(words) == 1 ):
  words = input_directory.split('\\')
input_directory_base = words[-1]
print( input_directory_base )

plot_output_filename = input_directory_base + ".encoding_time_in_seconds.png"
plt.savefig('plots/{}'.format(plot_output_filename), dpi=300)

##############################################################################

plt.figure(figsize=(12,6))
ax = plt.subplot(211)
titles = list(output_directory_values_lossless)
values = []
colours = []
labels = list(titles)

for key in titles:
  if 'htj2k' in key:
    colours.append("#bf132d")
  elif 'ptiff' in key:
    colours.append('#827d7d')    
  else:
    colours.append("#2d3a75")

compressed_size_in_gigabytes_values_lossless = []
for i in range(len(compressed_size_in_bytes_values_lossless)):
  compressed_size_in_gigabytes_values_lossless.append(compressed_size_in_bytes_values_lossless[i] / (1024*1024*1024) )
data = np.array(compressed_size_in_gigabytes_values_lossless)
bars = plt.barh(range(len(data)), data, zorder=0, color=colours )
for i in range(len(labels)):
  plt.text(data[i] , i, f"({data[i]:.3f})", va = 'center')

plt.grid(True, axis='x', linestyle='--', linewidth=0.5, zorder=3 )
plt.yticks(range(len(data)), output_directory_values_lossless)
plt.ylabel(None)
plt.title("Storage Size for 50 IIIF images")
#plt.xlabel("Gigabytes")  
ax.set_xlim(left = 0, right = compressed_size_in_bytes_max/(1024*1024*1024)) 

plt.tight_layout()

ax = plt.subplot(212)
titles = list(output_directory_values_lossy)
values = []
colours = []
labels = list(titles)

for key in titles:
  if 'htj2k' in key:
    colours.append("#bf132d")
  elif 'ptiff' in key:
    colours.append('#827d7d')    
  else:
    colours.append("#2d3a75")

compressed_size_in_gigabytes_values_lossy = []
for i in range(len(compressed_size_in_bytes_values_lossy)):
  compressed_size_in_gigabytes_values_lossy.append(compressed_size_in_bytes_values_lossy[i] / (1024*1024*1024) )
data = np.array(compressed_size_in_gigabytes_values_lossy)
bars = plt.barh(range(len(data)), data, zorder=0, color=colours )
for i in range(len(labels)):
  plt.text(data[i] , i, f"({data[i]:.3f})", va = 'center')

plt.grid(True, axis='x', linestyle='--', linewidth=0.5, zorder=3 )
plt.yticks(range(len(data)), output_directory_values_lossy)
plt.ylabel(None)
plt.xlabel("storage size (GigaBytes)")  
ax.set_xlim(left = 0, right = compressed_size_in_bytes_max/(1024*1024*1024)) 
plt.tight_layout()

plot_output_filename = input_directory_base + ".compressed_size_in_gigabytes.png"
plt.savefig('plots/{}'.format(plot_output_filename), dpi=300)