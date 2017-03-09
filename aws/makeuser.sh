#!/bin/bash
# Script to add a set of users to Linux system (used for classes).
# Original idea from:
# http://www.nczonline.net/blog/2011/11/18/setting-up-multi-user-apache-on-ec2/

# What is the base login of the user.
# For example, if student, then student1, student2, etc...
# are made.
userbasename="student"
# How many?
totalusers=20
# Which password should the users use?
password=letmein

# Only run of we're root/sudo...
if [ $(id -u) -eq 0 ]; then
    for (( i=1; i<=$totalusers; i++ ))
    do
        username=$userbasename$i
        egrep "^$username:" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
            echo "$username exists, deleting user before proceeding."
            userdel -r $username
        fi
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
        useradd -m -p $pass $username
        if [ $? -eq 0 ]; then
            mkdir /home/$username/public_html
            chmod 711 /home/$username
            chmod 755 /home/$username/public_html
            chown -R $username /home/$username/public_html

            echo "$username has been added to system."
        else
            echo "ERROR: Failed to add $username."
        fi
    done
else
    echo "Only root may add a user to the system."
    exit 2
fi

