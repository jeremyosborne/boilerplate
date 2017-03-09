# Stuff for bash

Mac specific editions

```bash
# Added by josborne for colorized ls
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Recursively remove annoying things.
alias rmNUKE="find . -name '*.DS_Store' -type f -delete; find . -name 'node_modules' -type d -exec rm -rf {} +; find . -name '*.pyc' -type f -delete; find . -name '*.class' -type f -delete"
```

Date in a file name

```bash
zip -r folder_`date +"%Y_%m_%d"`.zip folder
```

Directory of script

```bash
###########################################################
# Directory containing running script
# no matter where the script is being called from
THIS_DIR="`dirname $0`"
# Create a central base directory to work from, allows for relative paths from
# a central location relative to the script being called
BASE_DIR=$THIS_DIR/..
########################################################################
```
