#!/bin/bash

# If *g* prefixed versions of stat and realpath are available use those
# Needed on Mac OSX if coreutils is installed with Homebrew
if [ -x "$(which grealpath 2> /dev/null)" ]
then
    REALPATH=grealpath
elif [ -x "$(which realpath 2> /dev/null)" ]
then
    REALPATH=realpath
else
    echo "ERROR 'realpath' or 'grealpath' not found, if you're on Mac OSX install 'coreutils' with Homebrew"
    exit 2
fi

if [ -x "$(which gstat 2> /dev/null)" ]
then
    STAT=gstat
elif [ -x "$(which stat 2> /dev/null)" ]
then
    STAT=stat
else
    echo "ERROR 'stat' or 'gstat' not found, if you're on Mac OSX install 'coreutils' with Homebrew"
    exit 2
fi

# Root directory under which every other paths are created
out="$(mktemp -d)"

trap 'rm -rf "$out"' exit

total=0
ok=0
no=0
while IFS=, read -r cwd abs rel
do
    # Skip comments
    if [[ "$cwd" == '#'* ]]
    then
        continue
    fi

    # Skip header row
    if [ -z "$header" ]
    then
        header="ok"
        continue
    else
        total=$(($total + 1))
    fi

    # Trim leading/trailing double quotes
    cwd="${cwd#\"}"
    cwd="${cwd%\"}"
    abs="${abs#\"}"
    abs="${abs%\"}"
    rel="${rel#\"}"
    rel="${rel%\"}"

    # Paths which will be created on disk
    out_cwd="$out/$cwd"
    out_abs="$out/$abs"
    out_rel="$out_cwd/$rel"

    # Sanity check for $cwd
    if [ -z "$cwd" ]
    then
        echo "ERROR illegal current working directory ($cwd), cannot be empty"
        exit 2
    elif [[ "$($REALPATH -sm "$out_cwd")" != "$out"* ]]
    then
        echo "ERROR illegal current working directory ($cwd), path out of boundary"
        exit 2
    elif [[ "$cwd" != /* ]]
    then
        echo "ERROR illegal current working directory ($cwd), must be an absolute path"
        exit 2
    else
        mkdir -p "$out_cwd"
    fi

    # Sanity check for $abs, skipping if there's nothing to check
    if [ -z "$abs" ]
    then
        no=$(($no + 1))
        continue
    elif [[ "$($REALPATH -sm "$out_abs")" != "$out"* ]]
    then
        echo "ERROR illegal absolute path ($abs), path out of boundary"
        exit 2
    elif [[ "$abs" != /* ]]
    then
        echo "ERROR illegal absolute path ($abs), must be an absolute path"
        exit 2
    else
        mkdir -p "$out_abs"
    fi

    # Sanity check for $rel, so that we don't end up with files outside $out
    if [ -z "$rel" ]
    then
        no=$(($no + 1))
        continue
    elif [[ "$($REALPATH -sm "$out_rel")" != "$out"* ]]
    then
        echo "ERROR illegal relative path ($rel), falls outside of current working directory ($cwd)"
        exit 2
    else
        mkdir -p "$out_rel"
    fi

    # Testing if created paths point to the same inode
    if [ "$($STAT -c %i "$out_abs")" != "$($STAT -c %i "$out_rel")" ]
    then
        echo "NO cwd=\"$cwd\""
        echo "   abs=\"$abs\""
        echo "   rel=\"$rel\""
        no=$(($no + 1))
    else
        ok=$(($ok + 1))
    fi
done < "${1:-paths.csv}"

# Sanity check for stats
if [ $(($ok + $no)) -ne $total ]
then
    echo "ERROR the number of OKs ($ok) and NOs ($no) should equal $total, but it was $(($ok + $no))"
fi

if [ $no -eq 0 ]
then
    echo "OK"
else
    echo "OK $ok"
    echo "NO $no"
    exit 1
fi
