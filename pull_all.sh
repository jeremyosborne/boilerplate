#
# For each directory we find, run the necessary git
# commands on it for backup.
for dir in "./"*; do
    if test -d "$dir"; then
        echo "working in $dir"
        cd $dir
        git fetch --tags --verbose
        git pull --all --verbose
        cd ..
    fi
done
