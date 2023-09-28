#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/ProcessNorthwestern_Thesis_Proposal_Template__1_43.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/1muN_/ULiPg.pdf";then
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
    1> './src/ProcessNorthwestern_Thesis_Proposal_Template__1_43.md'
then
    echo "some errors"
    exit 1
fi

echo '- [ProcessNorthwestern_Thesis_Proposal_Template__1_43](./ProcessNorthwestern_Thesis_Proposal_Template__1_43.md)' >> ./src/SUMMARY.md
