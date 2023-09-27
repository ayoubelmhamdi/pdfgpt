#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/ayoub.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/1jBCV/ayoub.pdf";then
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang en                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
    1>./src/ayoub.md
then
    echo "some errors"
    exit 1
fi

echo '- [ayoub](./ayoub.md)' >> ./src/SUMMARY.md
