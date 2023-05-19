import math 
import argparse
import json
import os
import subprocess

# set default arguments
#iiif_urls_filename_default = '../resources/iiif_urls/iiif_urls.txt'
#iiif_urls_filename_default = './resources/iiif_urls/iiif_urls.txt'
iiif_urls_filename_default = '../resources/iiif_urls/uv_urls.txt'
#iiif_urls_filename_default = './resources/iiif_urls/uv_urls.txt'

compressed_directory_with_j2c_files_default = '../../compressed/htj2k_lossy_Qfactor_90_codeblock_64,64/'
iiif_json_directory_default = '../resources/info_json/'
#iiif_json_directory_default = './resources/info_json/'
output_script_filename_default = 'decode_iiif_urls.sh'
path_to_kdu_buffered_expand_executable_default = 'kdu_buffered_expand'
#path_to_kdu_buffered_expand_executable_default = '/mnt/c/data/consulting/tech/kakadu/kakadu_8.3/v8_3-00462N/bin/Linux-x86-64-gcc/kdu_buffered_expand'
compressed_file_extension_default = ".jph"
logs_directory_default = '../../logs'
number_of_decoding_cycle_iterations_default = 10
number_of_decoding_threads_default = str(int(subprocess.check_output("nproc", shell=True)))

parser = argparse.ArgumentParser(description="converts IIIF URLs into Kakadu kdu_buffered_expand commands")
parser.add_argument('--iiif_urls_filename',
                      help="filename of text file containing IIIF URLs. default is --iiif_urls_filename \"%s\"" % (iiif_urls_filename_default) ) 
parser.add_argument("--compressed_directory", 
                      help="directory where input j2c files are located. default is --compressed_directory \"%s\"" % (compressed_directory_with_j2c_files_default) )
parser.add_argument("--iiif_json_directory", 
                      help="directory where iiif json files are located. default is --iiif_json_directory \"%s\"" % (iiif_json_directory_default) )
parser.add_argument('--output_script_filename',
                      help="filename of output script containing calls to kdu_buffered_expand. default is --output_script_filename \"%s\"" % (output_script_filename_default) )
parser.add_argument('--path_to_kdu_buffered_expand_executable',
                      help="path to kdu_buffered_expand executable. default is --path_to_kdu_buffered_expand_executable \"%s\"" % (path_to_kdu_buffered_expand_executable_default) ) 
parser.add_argument('--compressed_file_extension',
                      help="compressed file extension. default is --compressed_file_extension \"%s\"" % (compressed_file_extension_default) ) 
parser.add_argument("--logs_directory", 
                      help="directory where log files will be written. default is --logs_directory \"%s\"" % (logs_directory_default) )
parser.add_argument("--number_of_decoding_cycle_iterations", 
                      help="number of decoding iteration cycles. default is --number_of_decoding_cycle_iterations \"%s\"" % (number_of_decoding_cycle_iterations_default) )
parser.add_argument("--number_of_decoding_threads", 
                      help="number of decoding threads. default is --number_of_decoding_threads \"%s\"" % (number_of_decoding_threads_default) )

args = parser.parse_args()

if( args.iiif_urls_filename ) :
  iiif_urls_filename = args.iiif_urls_filename
  print("processed --output_filename ", iiif_urls_filename )
else:
  iiif_urls_filename = iiif_urls_filename_default
  print("--iiif_urls_filename command line argument not provided, using default = ", iiif_urls_filename )

if( args.compressed_directory ) :
  compressed_directory = args.compressed_directory
  print("processed --compressed_directory ", compressed_directory )
else:
  compressed_directory = compressed_directory_with_j2c_files_default
  print("--compressed_directory command line argument not provided, using default = ", compressed_directory )

if( args.iiif_json_directory ) :
  iiif_json_directory = args.iiif_json_directory
  print("processed --iiif_json_directory ", iiif_json_directory )
else:
  iiif_json_directory = iiif_json_directory_default
  print("--iiif_json_directory command line argument not provided, using default = ", iiif_json_directory )

if( args.logs_directory ) :
  logs_directory = args.logs_directory
  print("processed --logs_directory ", logs_directory )
else:
  logs_directory = logs_directory_default
  print("--logs_directory command line argument not provided, using default = ", logs_directory )

if( args.output_script_filename ) :
  output_script_filename = args.output_script_filename
  print("processed --output_script_filename ", output_script_filename )
else:
  output_script_filename = output_script_filename_default
  print("--output_script_filename command line argument not provided, using default = ", output_script_filename )

if( args.path_to_kdu_buffered_expand_executable ) :
  path_to_kdu_buffered_expand_executable = args.path_to_kdu_buffered_expand_executable
  print("processed --path_to_kdu_buffered_expand_executable ", output_script_filename )
else:
  path_to_kdu_buffered_expand_executable = path_to_kdu_buffered_expand_executable_default
  print("--path_to_kdu_buffered_expand_executable command line argument not provided, using default = ", path_to_kdu_buffered_expand_executable )

if( args.compressed_file_extension ) :
  compressed_file_extension = args.compressed_file_extension
  print("processed --compressed_file_extension ", compressed_file_extension )
else:
  compressed_file_extension = compressed_file_extension_default
  print("--compressed_file_extension command line argument not provided, using default = ", compressed_file_extension )

if( args.number_of_decoding_cycle_iterations ) :
  number_of_decoding_cycle_iterations = args.number_of_decoding_cycle_iterations
  print("processed --number_of_decoding_cycle_iterations ", number_of_decoding_cycle_iterations )
else:
  number_of_decoding_cycle_iterations = number_of_decoding_cycle_iterations_default
  print("--number_of_decoding_cycle_iterations command line argument not provided, using default = ", number_of_decoding_cycle_iterations )

if( args.number_of_decoding_threads ) :
  number_of_decoding_threads = args.number_of_decoding_threads
  print("processed --number_of_decoding_threads ", number_of_decoding_threads )
else:
  number_of_decoding_threads = number_of_decoding_threads_default
  print("--number_of_decoding_threads command line argument not provided, using default = ", number_of_decoding_threads )

# open output file
output_script_file = open(output_script_filename, 'w')
output_script_file.write("#!/bin/bash\n")
output_script_file.write("set -u\n")
#output_script_file.write("export LD_LIBRARY_PATH=/mnt/c/data/consulting/tech/kakadu/kakadu_8.3/v8_3-00462N/lib/Linux-x86-64-gcc\n")

# set up log file
test_label = compressed_directory.replace("/", "_" )
test_label = test_label.replace("\\", "_" )
test_label = test_label.replace(".", "" )
output_script_file.write("# setup log files\n")
output_script_file.write("date_for_filename=`date +\"%Y-%m-%d-%H-%M-%S_%N\"`\n")
output_script_file.write("log_filename=\"" + logs_directory + "/" + test_label + ".${date_for_filename}.log.csv\"\n")
output_script_file.write("number_of_decoding_cycle_iterations=" + str(number_of_decoding_cycle_iterations) + "\n")
# write header to log file
output_script_file.write("# create log header\n")
output_script_file.write("printf \"compressed_directory,iiif_urls_filename,number_of_decoding_threads,\" > $log_filename\n")
output_script_file.write("for decoding_cycle_iteration in $(seq 1 $number_of_decoding_cycle_iterations); do\n")
output_script_file.write("  printf \"%d,\" $decoding_cycle_iteration >> $log_filename\n") 
output_script_file.write("done\n")
output_script_file.write("printf \"total_decoding_time_in_seconds\n\" >> $log_filename\n") 

# add output directory to log file  
output_script_file.write("# add compressed directory to log file\n")
output_script_file.write("printf \"\\\"" + compressed_directory + "\\\",\" >> $log_filename\n")

# add iiif_urls_filename to log file  
output_script_file.write("# add iiif_urls_filename to log file\n")
output_script_file.write("printf \"\\\"" + iiif_urls_filename + "\\\",\" >> $log_filename\n")

# add number of decoding threads to log file  
output_script_file.write("# add number_of_decoding_threads to log file\n")
output_script_file.write("printf \"\\\"" + number_of_decoding_threads + "\\\",\" >> $log_filename\n")

# start timer
output_script_file.write("# start job timer\n")
output_script_file.write("job_start_time=`date +%s%N`\n")
output_script_file.write("let duration_all_iterations_nanoseconds=0\n")

# setup decoding iteration loop
output_script_file.write("# setup decoding iteration loop\n")
output_script_file.write("for decoding_cycle_iteration in $(seq 1 $number_of_decoding_cycle_iterations)\n")
output_script_file.write("  do\n")
# start iteration timer
output_script_file.write("    # start iteration timer\n")
output_script_file.write("    start_iteration_time=`date +%s%N`\n")

output_script_file.write("# do decompression of compressed files according to iiif urls\n")

# open file with iiif urls
iiif_urls_file = open(iiif_urls_filename, 'r')
lines = iiif_urls_file.readlines()
for line in lines:

    # example iiif urls
    # gm_00002701.tif/10240,8192,588,34/!73,4/0/default.jpg
    # gm_36716601.tif/0,4096,4096,4096/256,/0/default.jpg
    # gm_13547101.tif/full/90,/0/default.jpg

    words = line.split('/')
    
    filename = words[0]
    # gm_00002701.tif
    filename_tokens = filename.split('.')
    filename_base = filename_tokens[0]
    filename_extension = filename_tokens[1]

    # skip this url if the json is requested
    if ("info.json\n" == words[1]):
      continue

    # 10240,8192,588,34
    # 0,4096,4096,4096
    # full
    elif ("full" == words[1]):
      # get resolution information from iiif_json
      iiif_json_filename = iiif_json_directory + filename_base + ".info.json"
      iiif_json_file = open(iiif_json_filename, 'r')
      iiif_json_dictionary = json.load(iiif_json_file)
      
      full_resolution_x = int(0)
      full_resolution_y = int(0)
      full_resolution_w = int(iiif_json_dictionary['width'])
      full_resolution_h = int(iiif_json_dictionary['height'])

      iiif_json_file.close()
    else:

      full_resolution_xywh = words[1]
    
      full_resolution_xywh_tokens = full_resolution_xywh.split(',')
      full_resolution_x = int(full_resolution_xywh_tokens[0])
      full_resolution_y = int(full_resolution_xywh_tokens[1])
      full_resolution_w = int(full_resolution_xywh_tokens[2])
      full_resolution_h = int(full_resolution_xywh_tokens[3])
    
    rendered_wh_with_exclamation = words[2]
    # !73,4
    # 256,
    # 90,
    rendered_wh = rendered_wh_with_exclamation.split('!')
    if( len(rendered_wh) > 1 ):
      rendered_wh_tokens = rendered_wh[1].split(',')
    else:
      rendered_wh_tokens = rendered_wh[0].split(',')

    is_rendered_h_provided = True
    rendered_w = int(rendered_wh_tokens[0])
    if( rendered_wh_tokens[1] == ""):
      # rendered height wasn't provided
      is_rendered_h_provided = False
    else:
      rendered_h = int(rendered_wh_tokens[1])

    # 0
    rotation_angle = float(words[3])
    
    # default.jpg
    output_filename = words[4]

    ## compute kdu_buffered_compress parameters

    # compute the scaling factor, compare the 100% region width to the desired width, 
    # i.e. 588 / 73 ~ 8 - this is the scaling factor
    scaling_factor_not_power_of_two = full_resolution_w / rendered_w
    scaling_factor_log2 = int( round( math.log2(scaling_factor_not_power_of_two) ) )
    scaling_factor = int( math.pow(2, scaling_factor_log2))

    # next, compute the region of interest x in the reduced resolution domain
    # divide the original x by the scaling factor, 10240 / 8 = 1280
    region_of_interest_x = int( round( float(full_resolution_x) / float(scaling_factor) ) )

    # compute the region of interest y in the reduced resolution domain, 
    # divide the original y by the scaling factor, 8192 / 8 = 1024
    region_of_interest_y = int( round( float(full_resolution_y) / float(scaling_factor) ) )

    # compute rendered_h if it wasn't provided
    if( is_rendered_h_provided == False ) :
      rendered_h = int( round( float(full_resolution_h) / float(scaling_factor) ) )

    # kdu_buffered_expand -i ..\compressed\gm_00002701.j2c -o ..\decompressed\gm_00002701_1024_1280_4_73_reduce_3.ppm -int_region {1024,1280},{4,73} -reduce 3 -num_threads 0
    kdu_buffered_expand_arguments = "-i " + compressed_directory + filename_base + compressed_file_extension + " -int_region \"{" + str(region_of_interest_y) + "," + str(region_of_interest_x) + "}\",\"{" + str(rendered_h) + "," + str(rendered_w) + "}\" " + "-reduce " + str(scaling_factor_log2) + " -num_threads " + str(number_of_decoding_threads)
    
    #print( "kdu_buffered_expand", kdu_buffered_expand_arguments)
    output_string = path_to_kdu_buffered_expand_executable + " " + kdu_buffered_expand_arguments + "\n"
    output_script_file.write(output_string)

# end iteration timer
output_script_file.write("    # end iteration timer\n")
output_script_file.write("    end_iteration_time=`date +%s%N`\n")

# compute timing stats for the decoding iteration
output_script_file.write("# compute timing stats for the decoding iteration\n")
output_script_file.write("let duration_nanoseconds=$end_iteration_time-$start_iteration_time\n")
output_script_file.write("number_of_nanoseconds_in_one_second=1000000000\n")
output_script_file.write("duration_iteration_total_seconds=$(echo \"scale=5;$duration_nanoseconds/$number_of_nanoseconds_in_one_second\" | bc)\n")

# print timing of decoding iteration to screen
output_script_file.write("# print timing of decoding iteration to screen\n")
output_script_file.write("printf \"duration_iteration_total_seconds=%s\\n\" $duration_iteration_total_seconds\n")

# print timing of decoding iteration to file
output_script_file.write("# print timing of decoding iteration to file\n")
output_script_file.write("printf \"%s,\" $duration_iteration_total_seconds >> $log_filename\n")

#end iteration loop
output_script_file.write("  done\n")

# stop job timer
output_script_file.write("# stop job timer\n")
output_script_file.write("job_end_time=`date +%s%N`\n")

# compute timing stats for the decoding job
output_script_file.write("# compute timing stats for the decoding job\n")
output_script_file.write("let duration_nanoseconds=$job_end_time-$job_start_time\n")
output_script_file.write("number_of_nanoseconds_in_one_second=1000000000\n")
output_script_file.write("duration_job_total_seconds=$(echo \"scale=5;$duration_nanoseconds/$number_of_nanoseconds_in_one_second\" | bc)\n")

# print timing of decoding to screen
output_script_file.write("# print timing of decoding to screen\n")
output_script_file.write("printf \"duration_job_total_seconds=%s\\n\" $duration_job_total_seconds\n")

# print timing of decoding to file
output_script_file.write("# print timing of decoding to file\n")
output_script_file.write("printf \"%s\\n\" $duration_job_total_seconds >> $log_filename\n")

# close files before exiting
output_script_file.close()
iiif_urls_file.close()
