#!/bin/bash

set -x

: "${TMPDIR:=/tmp}"

tmp_name="1.md"

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
    --provider Chatgptbz                   \
    1> './src/1-e8.md'
then
    echo "some errors" >&2
    exit 1
fi

echo '- [8](./1-e8.md)' >> ./src/SUMMARY.md
