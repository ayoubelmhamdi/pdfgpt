#!/bin/bash

CONVERSION=true

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract-ocr       \
    --lang fr                          \
    --llm correct_ocr  \
    --file 1.pdf \
    1>./src/1.md
then
    CONVERSION=false
    echo "some errors"
fi

echo "Ayoub04"
echo "CONVERSION=$CONVERSION" >> "$GITHUB_ENV"
