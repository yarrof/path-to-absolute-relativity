#!/bin/bash
#
# IMPORTANT: you don't need to edit/fix or do anything with this file,
# this is just a demonstration on how an "absolute path reference" (/home/jackie/stuff.csv)
# can make your program unusable on someone else's machine.
#
echo Reading from stuff.csv
while read
do
    echo $REPLY
done < /home/jackie/stuff.csv
