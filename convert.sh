#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

tmp_name="$TMPDIR/Northwestern_Thesis_Proposal_Template__1_ (43).pdf"
rm -f "$tmp_name"

if ! wget -q --output-document "$tmp_name" "";then
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr --llm paraphrasing  \
    --file "$tmp_name"                 \
    1>./src/Northwestern_Thesis_Proposal_Template__1_ (43).md
then
    echo "some errors"
    exit 1
fi

echo '- [Northwestern_Thesis_Proposal_Template__1_ (43)](./Northwestern_Thesis_Proposal_Template__1_ (43).md)' >> ./src/SUMMARY.md
