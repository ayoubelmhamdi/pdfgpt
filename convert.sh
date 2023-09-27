#!/bin/bash


if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr --llm paraphrasing  \
    --file 1.pdf \
    1>./src/1-2023-09-27-09:14.md
then
    echo "some errors"
    exit 1
fi

echo '- [1](./src/1-2023-09-27-09:14.md)' >> ./src/SUMMARY.md
