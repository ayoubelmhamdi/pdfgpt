#!/bin/bash

CONVERSION=true

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file 1.pdf \
    1>./src/1-2023-09-27-08:45.md
then
    CONVERSION=false
    echo "some errors"
    exit 1
fi

echo "CONVERSION=$CONVERSION" >> "$GITHUB_ENV"
