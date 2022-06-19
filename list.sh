#!/bin/bash
# get all filename in specified path遍历目录打印到list.txt

path=$1
files=$(ls $path)
for filename in $files
do
   echo file \'$filename\' >> list.txt
done