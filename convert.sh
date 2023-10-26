#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/Northwestern_Thesis_Proposal_Template__1_43.pdf"
name="Northwestern_Thesis_Proposal_Template__1_43"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/_CVDL/kUPAS.pdf";then
  echo "Can not use wget to download this file." >&2
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr --llm paraphrasing  \
    --file "$tmp_name"                 \
    --provider Chatgptbz               \
    1> "./src/${name}.md"
then
    echo "some errors" >&2
    exit 1
fi

echo "- [${name}](${name}.md)" >> ./src/SUMMARY.md
left="$(grep -o -e '\\(\(\([^\]*\)[^)]\+\))' -e '\\\[\(\([^\]*\)[^]]\+\)]' "./src/${name}.md" | wc -l)"
echo "left=$left"
dollar="$(grep -o '\$\+\([^$]\+\)\$\+' "./src/${name}.md" | wc -l)"
echo "dollar=$dollar"

if [ "$dollar" -gt "$left" ];then
  cat book_dollar.toml > book.toml
else
  cat book_left.toml > book.toml
fi
