#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/new_i.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/yMixm/new_i.pdf";then
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang en                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
    --provider Aivvm                   \
    1> './src/new_i.md'
then
    echo "some errors" >&2
    exit 1
fi

echo '- [new_i](./new_i.md)' >> ./src/SUMMARY.md
