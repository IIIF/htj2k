import math 
import argparse
import glob
import os
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
from statistics import median
    
#directory_with_csv_files_default = r'.\logs\2023-05-23.decoding.numthreads_16_8_4_2_1'
#directory_with_csv_files_default = ".\\logs\\2023-05-23.decoding.numthreads_16_8_4_2_1"
#directory_with_csv_files_default = "./logs/2023-05-23.decoding.numthreads_16_8_4_2_1"

#directory_with_csv_files_default = ".\\logs\\2023-05-28-decoding"
directory_with_csv_files_default = ".\\logs\\2023-05-29-decoding"

parser = argparse.ArgumentParser(description="Create dcoding performance plots")
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

all_values_array = np.empty([len(search_results),4], dtype=object)

search_index = 0
for search_result in search_results:
  
  words = search_result.split('/')
  if( len(words) == 1 ):
    words = search_result.split('\\')
  filename = words[-1]
  # print( filename )

  filename_tokens = filename.split('.')
  first_filename_token = filename_tokens[0]

  # print( first_filename_token )

  # making data frame 
  data = pd.read_csv(search_result) 
  
  # # iterating the columns
  # for col in data.columns:
  #   print(col)

  cols_to_add = ["compressed_directory","iiif_urls_filename","number_of_decoding_threads","1","2","3","4","5","total_decoding_time_in_seconds"]
  search_result_values_array = pd.read_csv(search_result, index_col=False, usecols=cols_to_add)[cols_to_add].sort_values(by=["compressed_directory"], ascending=True).to_numpy()

  compressed_directory_full = search_result_values_array[0][0]
  words = compressed_directory_full.split('/')
  if( len(words) == 1 ):
    words = compressed_directory_full.split('\\')
  compressed_directory = words[-2]

  iiif_url_full = search_result_values_array[0][1]
  words = iiif_url_full.split('/')
  if( len(words) == 1 ):
    words = iiif_url_full.split('\\')
  iiif_url = words[-1]

  all_values_array[search_index][0] = compressed_directory
  all_values_array[search_index][1] = iiif_url #search_result_values_array[0][1] # iiif_urls_filename
  all_values_array[search_index][2] = search_result_values_array[0][2] # number_of_decoding_threads
  all_values_array[search_index][3] = median([
    search_result_values_array[0][3], # 1
    search_result_values_array[0][4], # 2
    search_result_values_array[0][5], # 3
    search_result_values_array[0][6], # 4
    search_result_values_array[0][7] ]) # 5 
  #all_values_array[search_index][8] = search_result_values_array[0][8] # total_decoding_time_in_seconds

  search_index = search_index + 1

compressed_directory_values = all_values_array[:,0]
iiif_url_values = all_values_array[:,1]
number_of_decoding_threads_values = all_values_array[:,2]
decode_time_in_seconds_median_values = all_values_array[:,3]
# print(compressed_directory_values)
# print(iiif_url_values)
# print(number_of_decoding_threads_values)
# print(decode_time_in_seconds_median_values)

# find unique values
compressed_directory_set = sorted(set( compressed_directory_values ))
iiif_url_set = sorted( set(iiif_url_values) )
number_of_decoding_threads_set = sorted( set(number_of_decoding_threads_values) )

number_of_unique_combinations = len(compressed_directory_set) * len(iiif_url_set) * len(number_of_decoding_threads_set)
number_of_compressed_directory_values = len(compressed_directory_values)
number_of_iiif_url_values = len(iiif_url_values)
number_of_number_of_decoding_threads_values = len(number_of_decoding_threads_values)
number_of_decode_time_in_seconds_median_values = len(decode_time_in_seconds_median_values)
incomplete_or_duplicate_test_set_likely = False
if( (number_of_unique_combinations != number_of_compressed_directory_values) or 
    (number_of_unique_combinations != number_of_iiif_url_values) or
    (number_of_unique_combinations != number_of_number_of_decoding_threads_values) or
    (number_of_unique_combinations != number_of_decode_time_in_seconds_median_values)
    ) :
  incomplete_or_duplicate_test_set_likely = True
  print("**********************************")
  print("**********************************")
  print("\t incomplete_or_duplicate_test_set_likely")
  print("**********************************")
  print("**********************************")
else:
  print("**********************************")
  print("input data set does not contain duplicates: \n\t number_of_unique_combinations " 
        + str(number_of_unique_combinations) + " is equal to the length of the data set" )
  print("**********************************")

print("number_of_unique_combinations = " + str(number_of_unique_combinations))
print("\t len(compressed_directory_values) = " + str(number_of_compressed_directory_values))
print("\t len(iiif_url_values) = " + str(number_of_iiif_url_values))
print("\t len(number_of_decoding_threads_values) = " + str(number_of_number_of_decoding_threads_values))
print("\t len(decode_time_in_seconds_median_values) = " + str(number_of_decode_time_in_seconds_median_values))

print( "unique iiif_url values:" )
for iiif_url in iiif_url_set:
  print( "\t" + iiif_url )

print( "unique compressed_directory values:" )
for compressed_directory in compressed_directory_set:
  print( "\t" + compressed_directory )

print( "unique number_of_decoding_threads values:" )
for number_of_decoding_threads in number_of_decoding_threads_set:
  print( "\t" + str(number_of_decoding_threads) )

# make a plot for each unique iiif_url
for iiif_url in iiif_url_set:
  print( "\t" + iiif_url )

  compressed_directory_values_for_plot = []
  number_of_decoding_threads_values_for_plot = []
  decode_time_in_seconds_median_values_for_plot = []

  for index in range(len(compressed_directory_values)) :
    # find all the values corresponding to this iiif_url
    if( iiif_url_values[index].find(iiif_url) >= 0) :
      compressed_directory_values_for_plot.append(compressed_directory_values[index])
      number_of_decoding_threads_values_for_plot.append(number_of_decoding_threads_values[index])
      decode_time_in_seconds_median_values_for_plot.append(decode_time_in_seconds_median_values[index])

  # find the best value across all the number of threads arguments
  compressed_directory_values_for_plot_best_num_threads = []
  number_of_decoding_threads_values_for_plot_best_num_threads = []
  decode_time_in_seconds_median_values_for_plot_best_num_threads = []
  for compressed_directory in compressed_directory_set :

    compressed_directory_values_num_threads = []
    number_of_decoding_threads_values_num_threads = []
    decode_time_in_seconds_median_values_num_threads = []

    for input_list_index in range(len(compressed_directory_values_for_plot)) :
      if( compressed_directory_values_for_plot[input_list_index].find(compressed_directory) >= 0 ) :
          
          compressed_directory_values_num_threads.append( compressed_directory_values_for_plot[input_list_index])
          number_of_decoding_threads_values_num_threads.append( number_of_decoding_threads_values_for_plot[input_list_index])
          decode_time_in_seconds_median_values_num_threads.append( decode_time_in_seconds_median_values_for_plot[input_list_index])

    # print(compressed_directory_values_num_threads) 
    # print(number_of_decoding_threads_values_num_threads) 
    # print(decode_time_in_seconds_median_values_num_threads) 

    sort_indices = np.argsort( np.array(decode_time_in_seconds_median_values_num_threads) )
    compressed_directory_values_num_threads_sorted = np.array( np.array(compressed_directory_values_num_threads) )[sort_indices]    
    number_of_decoding_threads_values_num_threads_sorted = np.array( np.array(number_of_decoding_threads_values_num_threads) )[sort_indices]
    decode_time_in_seconds_median_values_num_thread_sorted = np.array( np.array(decode_time_in_seconds_median_values_num_threads) )[sort_indices]

    # print(sort_indices) 
    # print(compressed_directory_values_num_threads_sorted) 
    # print(number_of_decoding_threads_values_num_threads_sorted) 
    # print(decode_time_in_seconds_median_values_num_thread_sorted)

    compressed_directory_values_for_plot_best_num_threads.append(compressed_directory_values_num_threads_sorted[0])
    number_of_decoding_threads_values_for_plot_best_num_threads.append(number_of_decoding_threads_values_num_threads_sorted[0])
    decode_time_in_seconds_median_values_for_plot_best_num_threads.append(decode_time_in_seconds_median_values_num_thread_sorted[0])

    #print("here")

  # split results into 2 groups, lossless and lossy
  compressed_directory_values_for_plot_best_num_threads_lossless = []
  number_of_decoding_threads_values_for_plot_best_num_threads_lossless = []
  decode_time_in_seconds_median_values_for_plot_best_num_threads_lossless = []
  compressed_directory_values_for_plot_best_num_threads_lossy = []
  number_of_decoding_threads_values_for_plot_best_num_threads_lossy = []
  decode_time_in_seconds_median_values_for_plot_best_num_threads_lossy = []
  for index in range(len(compressed_directory_values_for_plot_best_num_threads)):
  
    if( compressed_directory_values_for_plot_best_num_threads[index].find("lossless") >= 0):
      compressed_directory_values_for_plot_best_num_threads_lossless.append(compressed_directory_values_for_plot_best_num_threads[index])
      number_of_decoding_threads_values_for_plot_best_num_threads_lossless.append(number_of_decoding_threads_values_for_plot_best_num_threads[index])
      decode_time_in_seconds_median_values_for_plot_best_num_threads_lossless.append(decode_time_in_seconds_median_values_for_plot_best_num_threads[index])
    else:
      compressed_directory_values_for_plot_best_num_threads_lossy.append(compressed_directory_values_for_plot_best_num_threads[index])
      number_of_decoding_threads_values_for_plot_best_num_threads_lossy.append(number_of_decoding_threads_values_for_plot_best_num_threads[index])
      decode_time_in_seconds_median_values_for_plot_best_num_threads_lossy.append(decode_time_in_seconds_median_values_for_plot_best_num_threads[index])

  decode_time_in_seconds_max = max( 
  max(decode_time_in_seconds_median_values_for_plot_best_num_threads_lossless), 
  max(decode_time_in_seconds_median_values_for_plot_best_num_threads_lossy) )

  # make plot
  plt.figure(figsize=(18,6))
  ax = plt.subplot(211)
  titles = list(compressed_directory_values_for_plot_best_num_threads_lossless)
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

  data = np.array(decode_time_in_seconds_median_values_for_plot_best_num_threads_lossless)
  bars = plt.barh(range(len(data)), data, zorder=0, color=colours )
  for i in range(len(labels)):
    plt.text(data[i], i, f"({data[i]:.2f}) t={number_of_decoding_threads_values_for_plot_best_num_threads[i]}", va = 'center')

  plt.grid(True, axis='x', linestyle='--', linewidth=0.5, zorder=3 )
  plt.yticks(range(len(data)), compressed_directory_values_for_plot_best_num_threads_lossless)
  plt.ylabel(None)
  plt.title("Decoding Time for 50 IIIF images \n using " + iiif_url +"\n using AWS EC2 c5.4xlarge \n with EBS storage")
  #plt.xlabel("Decoding Time (seconds)") 
  ax.set_xlim(left = 0, right = decode_time_in_seconds_max)

  plt.tight_layout()

  ax = plt.subplot(212)
  titles = list(compressed_directory_values_for_plot_best_num_threads_lossy)
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

  data = np.array(decode_time_in_seconds_median_values_for_plot_best_num_threads_lossy)
  bars = plt.barh(range(len(data)), data, zorder=0, color=colours )
  for i in range(len(labels)):
    plt.text(data[i], i, f"({data[i]:.2f}) t={number_of_decoding_threads_values_for_plot_best_num_threads[i]}", va = 'center')

  plt.grid(True, axis='x', linestyle='--', linewidth=0.5, zorder=3 )
  plt.yticks(range(len(data)), compressed_directory_values_for_plot_best_num_threads_lossy)
  plt.ylabel(None)
  plt.xlabel("Decoding Time (seconds)") 
  ax.set_xlim(left = 0, right = decode_time_in_seconds_max)

  plt.tight_layout()

  #plt.show()
  words = input_directory.split('/')
  if( len(words) == 1 ):
    words = input_directory.split('\\')
  input_directory_base = words[-1]
  print( input_directory_base )

  plot_output_filename = input_directory_base + "." + iiif_url + ".decoding_time_in_seconds.png"
  plt.savefig('plots/{}'.format(plot_output_filename), dpi=300)
