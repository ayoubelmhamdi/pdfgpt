#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/2.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/K3aXD/2.pdf";then
  echo "Can not use wget to download this file." >&2
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
    --provider Aivvm                   \
    1> './src/2.md'
then
    echo "some errors" >&2
    exit 1
fi

sed -i -e 's#\\\[\(\([^\]*\)[^]]\+\)\\]#$$\1$$#g' -e 's#\\(\(\([^\]*\)[^]]\+\))#$\1$#g' './src/2.md'
echo '- [2](./2.md)' >> ./src/SUMMARY.md
