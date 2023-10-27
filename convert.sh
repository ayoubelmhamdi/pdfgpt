#!/bin/bash

set -x

tmp_name="2.md"
name="007"

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract-ocr           \
    --lang fr                          \
    --llm paraphrasing \
    --file "$tmp_name"                 \
    --provider Chatgptbz               \
    1> "./src/${name}.md"
then
    echo "some errors" >&2
    exit 1
fi



echo "- [${name}](${name}.md)" >> ./src/SUMMARY.md
left="$(grep -o -e '\\(\(\([^\]*\)[^)]\+\))' -e '\\\[\(\([^\]*\)[^]]\+\)]' "./src/${name}.md" | wc -l)"
dollar="$(grep -o '\$\+\([^$]\+\)\$\+' "./src/${name}.md" | wc -l)"
echo "left=$left"
echo "dollar=$dollar"

if [ "$dollar" -gt "$left" ];then
  cat book_dollar.toml > book.toml
else
  cat book_left.toml > book.toml
fi
