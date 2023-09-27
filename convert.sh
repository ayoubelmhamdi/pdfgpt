#!/bin/bash


if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang en                          \
    --llm paraphrasing  \
    --file 1.pdf \
    1>./src/1-2023-09-27-10_03.md
then
    echo "some errors"
    exit 1
fi

echo '- [1](./src/1-2023-09-27-10_03.md)' >> ./src/SUMMARY.md
