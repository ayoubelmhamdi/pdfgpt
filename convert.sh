#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/new_d.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/I3WN3/new_d.pdf";then
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
    --provider Aivvm                   \
    1> './src/new_d.md'
then
    echo "some errors" >&2
    exit 1
fi

echo '- [new_d](./new_d.md)' >> ./src/SUMMARY.md
