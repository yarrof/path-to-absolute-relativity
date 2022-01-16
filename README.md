# Path to Absolute Relativity

## Story

Your friend Jackie gave you a program, `prog.sh` that she's written the other day, but when you ran it this welcomed you

```sh
$ ./prog.sh
Reading from stuff.csv
./prog.sh: line 6: /home/jackie/stuff.csv: No such file or directory
```

You asked her *what's up with this thing?*, but she didn't knew and only said *works on my machine* ...

You've taken a look at the script and found that it contained a file path like `/home/jackie/stuff.csv` which seemed odd ... you looked into the matter to find out that this is an absolute file path, which obviously doesn't point to anything on *your* filesystem.

Since you know next to nothing about *file paths* in general you decided to master this concept.

Go get it tiger!

## What are you going to learn?

- What file paths are
- What relative and absolute file paths are
- What the current directory is (or *cwd* for short)
- How to get/calculate the absolute path to file using a relative path
- What do the `.` and `..` special files mean
- Learn a bit about the CSV file format and the basic structure

## Tasks

1. Edit the `paths.csv` and fill in the blanks (either the *Absolute Path* or *Relative Path*) based on the value of the *Current Working Directory* and use `/test.sh` to validate your solution.

```
+---------------------------+--------------------+---------------+
| Current Working Directory | Absolute Path      | Relative Path |
+---------------------------+--------------------+---------------+
| /var/lib/postgresql/data  |                    | ../../mysql   |
+---------------------------+--------------------+---------------+
| /etc                      | /etc/apache/conf   |               |
+---------------------------+--------------------+---------------+
```

The first (absolute path) blank should be `/var/lib/mysql`.
The second (relative path) blank should be `apache/conf`.
    - Filled in blanks in the *Absolute Path* column in `paths.csv`
    - Filled in blanks in the *Relative Path* column in `paths.csv`
    - `./test.sh` outputs `OK` (execution might take a few seconds)

## General requirements

- `test.sh` is not modified
- Only blank cells are modified in `paths.csv`, prefilled cells are not

## Hints

- Don't edit/fix or do anything with `prog.sh`, it's just a demonstration on how an "absolute path reference" (`/home/jackie/stuff.csv`) can make your program unusable on someone else's machine
- When running `./test.sh` if you get back lots of `NO`s and zero `OK`s then there might be a problem with the newline characters in your files, if running `file test.sh` displays `test.sh: Bourne-Again shell script, ASCII text executable, with CRLF line terminators` (please note **CRLF line terminators**) then you've made a mistake while cloning the project, there are two ways to fix this:
    1. Run `dos2unix *` in the folder where the scripts are (this is a temporary solution, you'll bump into such issues again)
    2. Configure Git so that it clones files correctly next time with this command: `git config --global core.autocrlf false` (still run the previous command, because this'll take effect on new `git clone` commands in the future)
- If you receive errors when running `./test.sh` on Mac OSX install the `coreutils` package with Homebrew, or install the GNU version of `realpath` and `stat` by any other means you can
- Make sure to check the first few lines in `paths.csv` since there are examples of good solutions in there!
- Don't use spaces in filenames in your everyday life despite seeing some files with names containing whitespace characters in this project
- However, if you ever need to deal with such a thing make sure to _quote_ such paths, e.g. `ls -la 'Directory Name With Spaces'` or using double quotes like `ls -la "/tmp/Attack of the Spaces"`
- To create symlinks to files *not in your current working directory* use an absolute path (e.g. `ln -s /some/file/somewhere.txt ../target/path/linked.txt`) or use the `-r` flag with a relative path (e.g. `ln -sr ../some/file/somewhere.txt ../target/path/linked.txt`), otherwise `ln` is going to create dead symlinks
- When editing CSV files make sure to use quotes if the values in the cells are surrounded by them
- **When you are reading background materials:**
  - [Basic rules of CSV files](https://en.wikipedia.org/wiki/Comma-separated_values#Basic_rules) (it's all very intuitive, but make sure to understand what a "quoted field" is in CSV terminology (look at the examples), this quoting of things or "escaping" comes handy in a lot of situations)
  - [Downloadable `paths.csv`](https://docs.google.com/spreadsheets/d/1XE_e39W6DL0zBAmA8c98rsA9F9yyj2ojg9tufw0HZr4/gviz/tq?tqx=out:csv;outFileName:paths.csv&sheet=Exercise&range=A:C) (here's [the Google Spreadsheet version of the same CSV](https://docs.google.com/spreadsheets/d/1XE_e39W6DL0zBAmA8c98rsA9F9yyj2ojg9tufw0HZr4), which you cannot edit, but can copy it to your own Google Drive and export that as a CSV if you'd like)

## Background materials

- <i class="far fa-video"></i> <i class="far fa-exclamation"></i> [Absolute and Relative Paths](https://www.youtube.com/watch?v=ephId3mYu9o)
- <i class="far fa-book-open"></i> [Basic rules of CSV files](https://en.wikipedia.org/wiki/Comma-separated_values#Basic_rules)
- <i class="far fa-book-open"></i> [Downloadable `paths.csv`](https://docs.google.com/spreadsheets/d/1XE_e39W6DL0zBAmA8c98rsA9F9yyj2ojg9tufw0HZr4/gviz/tq?tqx=out:csv;outFileName:paths.csv&sheet=Exercise&range=A:C)
