#!/bin/bash

CONVERSION=true

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file 1.pdf \
    1>./src/1-2023-09-26-12:30.md
then
    CONVERSION=false
    echo "some errors"
    exit 1
fi

echo "Ayoub08"
echo "CONVERSION=$CONVERSION" >> "$GITHUB_ENV"
