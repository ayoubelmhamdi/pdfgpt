#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/new.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/xqub0/new.pdf";then
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! echo python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
    1>./src/new.md
then
    echo "some errors"
    exit 1
fi

echo '- [new](./new.md)' >> ./src/SUMMARY.md
