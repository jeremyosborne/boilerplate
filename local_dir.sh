########################################################################
#!/bin/bash
#
# Sample buildscript preamble that shows how to get the location of
# './' relative to this script.
#

###########################################################
# Local relative directory to the running script
# no matter where the script is being called from
THIS_DIR="`dirname $0`"
# Create a central base directory to work from, allows for relative paths from
# a central location relative to the script being called
BASE_DIR=$THIS_DIR/..
########################################################################
