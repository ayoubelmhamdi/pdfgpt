#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/Northwestern_Thesis_Proposal_Template__1_43.pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "https://bashupload.com/KRbZg/26Qdl.pdf";then
  echo "Can not use wget to download this file." >&2
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr --llm paraphrasing  \
    --file "$tmp_name"                 \
    --provider Aivvm                   \
    1> './src/Northwestern_Thesis_Proposal_Template__1_43.md'
then
    echo "some errors" >&2
    exit 1
fi

echo '- [Northwestern_Thesis_Proposal_Template__1_43](./Northwestern_Thesis_Proposal_Template__1_43.md)' >> ./src/SUMMARY.md
