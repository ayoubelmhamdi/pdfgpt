#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="1.md"
# rm -f "$tmp_name"
#
# if ! wget -q --output-document "$tmp_name" "https://bashupload.com/l08VD/1.md";then
#   echo "Can not use wget to download this file." >&2
#   exit 1
# fi
#
# clear



if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
    --provider Chatgptbz                   \
    1> './src/1-e2.md'
then
    echo "some errors" >&2
    exit 1
fi

echo '- [1](./1-e2.md)' >> ./src/SUMMARY.md
