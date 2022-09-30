#!/usr/bin/env bash

# Important: it is assumed this script is ran from the directory
# that is the parent of the directory to rename

oldname=$1
newname=$2

function renamefile ()
{
    # file name is input parameter
    if [[ $1 =~ (.*)($oldname)(.*) ]]
    then
        echo "changing $1 to ${BASH_REMATCH[1]}$newname${BASH_REMATCH[3]}"
        mv "$1" "${BASH_REMATCH[1]}$newname${BASH_REMATCH[3]}"

    fi

}

echo "Renaming build $oldname to $newname"

fromString=$oldname
toString=$newname
replaceCommand="s!${fromString}!${toString}!g"

# not all these file types may exist, we include all the commonly used ones, though,
# just in case future changes to site files started to have them. There is no harm, per se,
# if the perl command fails.
# TODO: could add some "smarts" here to see if all was as expected before making changes.
perl -w -pi -e ${replaceCommand} ${oldname}/*.php
perl -w -pi -e ${replaceCommand} ${oldname}/*.map
perl -w -pi -e ${replaceCommand} ${oldname}/*.html
perl -w -pi -e ${replaceCommand} ${oldname}/*.xml
perl -w -pi -e ${replaceCommand} ${oldname}/checksum/*

# move directory before file renames, so it won't be in file path name twice
mv $oldname $newname

for file in `find ./${newname} -name "*${oldname}*" -print `
do
    renamefile $file
done

