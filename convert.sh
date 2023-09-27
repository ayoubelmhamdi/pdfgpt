#!/bin/bash


if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang en                          \
    --llm correct_ocr  \
    --file 1.pdf \
    1>./src/1-2023-09-27-10_17.md
then
    echo "some errors"
    exit 1
fi

echo '- [1](./1-2023-09-27-10_17.md)' >> ./src/SUMMARY.md
