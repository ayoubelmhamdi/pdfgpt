#!/bin/bash

CONVERSION=true

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file 1.pdf \
    1>./src/1.md
then
    CONVERSION=false
    echo "some errors"
    exit 1
fi

echo "Ayoub07"
echo "CONVERSION=$CONVERSION" >> "$GITHUB_ENV"