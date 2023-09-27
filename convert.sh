#!/bin/bash


if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file p10.pdf \
    1>./src/p10.md
then
    echo "some errors"
    exit 1
fi

echo '- [p10]()' >> ./src/SUMMARY.md
