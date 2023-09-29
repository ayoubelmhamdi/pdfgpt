#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/new_b.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/lcGVt/new_b.pdf";then
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr --llm paraphrasing  \
    --file "$tmp_name"                 \
    --provider Aivvm                   \
    1> './src/new_b.md'
then
    echo "some errors" >&2
    exit 1
fi

echo '- [new_b](./new_b.md)' >> ./src/SUMMARY.md
