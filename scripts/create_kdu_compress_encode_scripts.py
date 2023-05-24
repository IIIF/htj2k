import math 
import argparse
import os
import subprocess

source_directory_default = '../../source_images'
#source_directory_default = '../source_images'
compressed_directory_default = '../../compressed'
logs_directory_default = '../../logs'
output_script_filename_prefix_default = 'encode'
path_to_kdu_compress_executable_default = 'kdu_compress'
#path_to_kdu_compress_executable_default = '/mnt/c/data/consulting/tech/kakadu/kakadu_8.3/v8_3-00462N/bin/Linux-x86-64-gcc/kdu_compress'
compressed_file_extension_default = ".jph"
encoding_parameter_set_default = 6
smallest_thumbnail_dimension_default = 90

parser = argparse.ArgumentParser(description="creates bash script to convert TIF files into JPEG2000 files using kdu_compress commands")
parser.add_argument('--source_directory',
                      help="directory where the input TIF files are located. default is --source_directory \"%s\"" % (source_directory_default), default=source_directory_default) 
parser.add_argument("--compressed_directory", 
                      help="directory where output files will be written. default is --compressed_directory \"%s\"" % (compressed_directory_default), default=source_directory_default )
parser.add_argument("--logs_directory", 
                      help="directory where log files will be written. default is --logs_directory \"%s\"" % (logs_directory_default), default=logs_directory_default )
parser.add_argument('--output_script_filename_prefix',
                      help="filename prefix of output script containing calls to kdu_compress. default is --output_script_filename_prefix \"%s\"" % output_script_filename_prefix_default, default=output_script_filename_prefix_default)
parser.add_argument('--path_to_kdu_compress_executable',
                      help="path to kdu_compress executable. default is --path_to_kdu_compress_executable \"%s\"" % (path_to_kdu_compress_executable_default), default=path_to_kdu_compress_executable_default) 
parser.add_argument('--compressed_file_extension',
                      help="compressed file extension. default is --compressed_file_extension \"%s\"" % (compressed_file_extension_default), default=compressed_file_extension_default )
parser.add_argument('--is_Clevels_image_size_dependent',
                      help="Use False to use a fixed Clevels value for all images.  The default is True.",
                      type=eval, 
                      choices=[True, False], 
                      default='True')
parser.add_argument('--encoding_parameter_set',
                      help="encoding parameter preset value (see python code for preset values to encoding parameter mapping). default is --encoding_parameter_set \"%s\"" % (encoding_parameter_set_default),
                       default=encoding_parameter_set_default)
parser.add_argument('--smallest_thumbnail_dimension',
                      help="The smallest thumbnail size that will be requested when decoding. default is --smallest_thumbnail_dimension \"%s\"" % (smallest_thumbnail_dimension_default),
                       default=smallest_thumbnail_dimension_default )

parser.add_argument('--exclude-timing',
                      help="Include script timing. Note this doesn't work on MacOSX which has a different date command",
                       action='store_false')

args = parser.parse_args()

source_directory = args.source_directory
compressed_directory = args.compressed_directory
logs_directory = args.logs_directory
output_script_filename_prefix = args.output_script_filename_prefix
compressed_file_extension = args.compressed_file_extension
encoding_parameter_set = int(args.encoding_parameter_set)
smallest_thumbnail_dimension = int(args.smallest_thumbnail_dimension)

#codeblock_parameters = ["32,32", "64,64", "32,128"]
codeblock_parameters = ["64,64"]

list_of_source_files = os.listdir( source_directory )
input_file_extension = ".tif"
output_file_extension = compressed_file_extension

for codeblock_parameter in codeblock_parameters:
  print("codeblock_parameter = " + codeblock_parameter)

  # set encoding parameters and label prefix
  if encoding_parameter_set == 0:
    # HT lossy Qfactor 90
    encoding_parameters="Cmodes=HT Creversible=no Qfactor=90 Cblk=\"{" + codeblock_parameter + "}\""
    test_label_prefix="htj2k_lossy_Qfactor_90_codeblock"
  elif encoding_parameter_set == 1:
    # HT lossless
    encoding_parameters="Cmodes=HT Creversible=yes Cblk=\"{" + codeblock_parameter + "}\""
    test_label_prefix="htj2k_lossless_codeblock"
  elif encoding_parameter_set == 2:
    # digital bodelian - lossless - https://image-processing.readthedocs.io/en/latest/jp2_profile.html#kduusage
    encoding_parameters="\"Cprecincts={256,256},{256,256},{128,128}\" \"Stiles={512,512}\" Corder=RPCL ORGgen_plt=yes ORGtparts=R \"Cblk={64,64}\" Cuse_sop=yes Cuse_eph=yes -flush_period 1024 Creversible=yes -rate -"
    test_label_prefix="j2k1_digital_bodelian_lossless_codeblock"
    output_file_extension = '.jp2'
  elif encoding_parameter_set == 3:
    # digital bodelian - lossy - https://image-processing.readthedocs.io/en/latest/jp2_profile.html#kduusage
    encoding_parameters="\"Cprecincts={256,256},{256,256},{128,128}\" \"Stiles={512,512}\" Corder=RPCL ORGgen_plt=yes ORGtparts=R \"Cblk={64,64}\" Cuse_sop=yes Cuse_eph=yes -flush_period 1024 -rate 3"
    test_label_prefix="j2k1_digital_bodelian_lossy_codeblock"
    output_file_extension = '.jp2'
  elif encoding_parameter_set == 4:
    # HT digital bodelian - lossless - https://image-processing.readthedocs.io/en/latest/jp2_profile.html#kduusage
    encoding_parameters="\"Cprecincts={256,256},{256,256},{128,128}\" \"Stiles={512,512}\" Corder=RPCL ORGgen_plt=yes ORGtparts=R \"Cblk={64,64}\" Cuse_sop=yes Cuse_eph=yes -flush_period 1024 Creversible=yes Cmodes=HT -rate -"
    test_label_prefix="htj2k_digital_bodelian_lossy_codeblock"
  elif encoding_parameter_set == 5:
    # HT digital bodelian - lossy - https://image-processing.readthedocs.io/en/latest/jp2_profile.html#kduusage
    encoding_parameters="\"Cprecincts={256,256},{256,256},{128,128}\" \"Stiles={512,512}\" Corder=RPCL ORGgen_plt=yes ORGtparts=R \"Cblk={64,64}\" Cuse_sop=yes Cuse_eph=yes -flush_period 1024 Cmodes=HT Cplex=\"{6,EST,0.25,-1}\" -rate 3"
    test_label_prefix="htj2k_digital_bodelian_lossless_codeblock"
  elif encoding_parameter_set == 6:
    # HT lossless with PLT
    encoding_parameters="Cmodes=HT Creversible=yes ORGgen_plt=yes Cblk=\"{" + codeblock_parameter + "}\""
    test_label_prefix="htj2k_lossless_plt_codeblock"
  elif encoding_parameter_set == 7:
    # j2k1 lossless with PLT
    encoding_parameters="Creversible=yes ORGgen_plt=yes Corder=RPCL Cprecincts=\"{256,256}\" Cblk=\"{" + codeblock_parameter + "}\""
    test_label_prefix="j2k1_lossless_plt_codeblock"
    output_file_extension = '.jp2'
  elif encoding_parameter_set == 8:
    # HT lossy Qfactor 90 with PLT
    encoding_parameters="Cmodes=HT Creversible=no Qfactor=90 ORGgen_plt=yes Cblk=\"{" + codeblock_parameter + "}\""
    test_label_prefix="htj2k_lossy_Qfactor_90_plt_codeblock"
  elif encoding_parameter_set == 9:
    # HT lossy 3.0 bpp with PLT
    encoding_parameters="Cmodes=HT Creversible=no -rate 3 Cplex=\"{6,EST,0.25,-1}\" ORGgen_plt=yes Cblk=\"{" + codeblock_parameter + "}\""
    test_label_prefix="htj2k_lossy_3bpp_plt_codeblock"
  elif encoding_parameter_set == 10:
    # j2k1 lossy 3.0 bpp with PLT
    encoding_parameters="Creversible=no -rate 3 Corder=RPCL Cprecincts=\"{256,256}\" ORGgen_plt=yes Cblk=\"{" + codeblock_parameter + "}\""
    test_label_prefix="j2k1_lossy_3bpp_plt_codeblock"
    output_file_extension = '.jp2'
  else:
    print( "encoding_parameter_set = '" + str(encoding_parameter_set) + "' is not supported yet, exiting" )
    exit( -1 )

  test_label = test_label_prefix + "_" + codeblock_parameter

  output_script_filename = output_script_filename_prefix + "_" + test_label + ".sh"

  # open output file
  output_script_file = open(output_script_filename, 'w')
  output_script_file.write("#!/bin/bash\n")

  # set path to kdu when running in WSL
  #output_script_file.write("export LD_LIBRARY_PATH=/mnt/c/data/consulting/tech/kakadu/kakadu_8.3/v8_3-00462N/lib/Linux-x86-64-gcc\n")

  output_directory = os.path.join(compressed_directory, test_label)
  output_script_file.write("mkdir -p " + output_directory + "\n")

  # set up log file
  output_script_file.write("# setup log files\n")
  if args.exclude_timing:
    output_script_file.write("date_for_filename=`date +\"%Y-%m-%d-%H-%M-%S_%N\"`\n")
    output_script_file.write("log_filename=\"" + logs_directory + "/" + test_label + ".${date_for_filename}.log.csv\"\n")
 
    # write header to log file
    output_script_file.write("# create log header\n")
    output_script_file.write("printf \"output_directory,encode_time_in_seconds,compressed_size_in_bytes\n\" > $log_filename\n")

    # add output directory to log file  
    output_script_file.write("# add output directory to log file\n")
    output_script_file.write("printf \"\\\"" + output_directory + "\\\",\" >> $log_filename\n")

    # start timer
    output_script_file.write("# start timer\n")
    output_script_file.write("job_start_time=`date +%s%N`\n")

    output_script_file.write("# do compression of input files\n")
  for source_file in list_of_source_files:
      
    if source_file.endswith(input_file_extension):

      basename = os.path.splitext(source_file)[0]

      input_filename = source_directory + "/" + source_file
      output_filename = output_directory + "/" + basename + output_file_extension

      if( True == args.is_Clevels_image_size_dependent ):
        # use image magick to get input image width and image height - use [0] to get only the first image in a multi-directory tif
        cmd = "identify -ping -quiet -format \"%w\" " + input_filename + "[0]"
        image_width = int(subprocess.check_output(cmd, shell=True))
        #image_width = int(subprocess.run(cmd, check=False))
        cmd = "identify -ping -quiet -format \"%h\" " + input_filename + "[0]"
        image_height = int(subprocess.check_output(cmd, shell=True))
        #image_height = int(subprocess.run(cmd, shell=True, check=False))
        #output_script_file.write("printf \"" + return_value + "\n\"")
        if ( image_width > image_height ) :
          max_dimension = image_width
        else:
          max_dimension = image_height
        maxmium_scaling_factor = max_dimension / smallest_thumbnail_dimension
        log2_max_scaling_factor = math.log2( maxmium_scaling_factor )
        #Clevels_parameter = int(math.ceil( log2_max_scaling_factor + 1))
        Clevels_parameter = int(math.ceil( log2_max_scaling_factor))
        # debug info if we find a huge image
        if( Clevels_parameter > 8 ) :
          print( "image filename = " + source_file)
          print( "image_width,image_height = " + str(image_width) + "," + str(image_height))
          print( "max_dimension = " + str(max_dimension) )
          print( "log2_max_scaling_factor = " + str(log2_max_scaling_factor) )
          print( "Clevels_parameter = " + str(Clevels_parameter) )
      else:
        Clevels_parameter = 6

      kdu_compress_complete_parameters_without_i_and_o = encoding_parameters + " Clevels=" + str(Clevels_parameter)
      kdu_compress_command = args.path_to_kdu_compress_executable + " -i " + input_filename + " -o " + output_filename + " " + kdu_compress_complete_parameters_without_i_and_o
      # create kdu_compress command and include the command itself in a com marker
      kdu_compress_command_for_com_marker = "\"" + "kdu_compress " +  kdu_compress_complete_parameters_without_i_and_o.replace("\"", "\\\"" ) + "\""
      output_script_file.write(kdu_compress_command + " -com " + kdu_compress_command_for_com_marker + "\n")

  if args.exclude_timing:
    # stop timer
    output_script_file.write("# stop timer\n")
    output_script_file.write("job_end_time=`date +%s%N`\n")

    # compute timing stats for the encoding
    output_script_file.write("# compute timing stats for the encoding\n")
    output_script_file.write("let duration_nanoseconds=$job_end_time-$job_start_time\n")
    output_script_file.write("number_of_nanoseconds_in_one_second=1000000000\n")
    output_script_file.write("duration_total_seconds=$(echo \"scale=5;$duration_nanoseconds/$number_of_nanoseconds_in_one_second\" | bc)\n")

    # print timing of encoding to screen
    output_script_file.write("# print timing of encoding to screen\n")
    output_script_file.write("printf \"duration_total_seconds=%s\n\" $duration_total_seconds\n")

    # print timing of encoding to file
    output_script_file.write("# print timing of encoding to file\n")
    output_script_file.write("printf \"%s,\" $duration_total_seconds >> $log_filename\n")

    # get number of bytes for the folder of compressed files
    output_script_file.write("# get number of bytes for the folder of compressed files\n")
    output_script_file.write("bytes_in_compressed_folder_with_dot_dir=`du -sb " + output_directory + " | awk '{print $1}'`\n")
    output_script_file.write("# subtract 4096 for the '.' dir\n")
    output_script_file.write("let bytes_in_compressed_folder=$bytes_in_compressed_folder_with_dot_dir-4096\n")

    # print results to screen
    output_script_file.write("# print results to screen\n")
    output_script_file.write("printf \"bytes_in_compressed_folder=%s\n\" $bytes_in_compressed_folder\n")

    # add timing info to log
    output_script_file.write("# add timing info to log\n")
    output_script_file.write("printf \"%s\n\" $bytes_in_compressed_folder >> $log_filename\n")

  # close files before exiting
  output_script_file.close()
