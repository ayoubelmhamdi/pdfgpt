#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/a2.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/EEdhn/a2.pdf";then
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
    1> './src/a2-2023-09-30-13_53.md'
then
    echo "some errors" >&2
    exit 1
fi

echo '- [a2](./a2-2023-09-30-13_53.md)' >> ./src/SUMMARY.md
