#!/bin/bash

CONVERSION=true

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang en                          \
    --llm correct_ocr  \
    --file 1.pdf \
    1>./src/1-2023-09-26-12:58.md
then
    CONVERSION=false
    echo "some errors"
    exit 1
fi

echo "CONVERSION=$CONVERSION" >> "$GITHUB_ENV"
