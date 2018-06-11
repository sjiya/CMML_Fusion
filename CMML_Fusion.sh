#!/bin/bash
#author: Sharaf Hussain
result="";
count=;
for file in $(pwd)/* 

do
cat $file | grep -o -P '(?<=displaystyle).*(?=}</annotation>)' |  sed 's/\\/\\\\/g'| while read LINE 
do
count=$((count+1))
printf "\n"
printf "$count :"
latexmlmath $LINE --cmml=quad.mml -
sed -i '/^<?xml.*/d' quad.mml
sed -i -E 's/^<math.*/<annotation-xml encoding="MathML-Content">/' quad.mml
sed -i -E 's/^<\/math>.*/<\/annotation-xml>/g' quad.mml

echo "Latex Equation: $LINE" 

result=$(cat quad.mml)

echo $result >> result.txt

done

java -jar RegexFindReplace.jar $file result.txt /home/sharaf/WikiDocs2/
echo -n "" > result.txt
done
