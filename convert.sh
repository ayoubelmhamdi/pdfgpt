#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

<<<<<<< Updated upstream
tmp_name="$TMPDIR/new_g.pdf"
||||||| Stash base
tmp_name="$TMPDIR/test01.pdf"
=======
tmp_name="$TMPDIR/Northwestern_Thesis_Proposal_Template__1_43.pdf"
>>>>>>> Stashed changes
rm -f "$tmp_name"

<<<<<<< Updated upstream
if ! wget -q --output-document "$tmp_name" "https://bashupload.com/RTWAB/new_g.pdf";then
||||||| Stash base
if ! wget -q --output-document "$tmp_name" "https://bashupload.com/QASxr/test01.pdf";then
=======
if ! wget -q --output-document "$tmp_name" "https://bashupload.com/Y03zc/98E9y.pdf";then
>>>>>>> Stashed changes
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr --llm paraphrasing  \
    --file "$tmp_name"                 \
    --provider Aivvm                   \
<<<<<<< Updated upstream
    1> './src/new_g.md'
||||||| Stash base
    1> './src/test01.md'
=======
    1> './src/Northwestern_Thesis_Proposal_Template__1_43.md'
>>>>>>> Stashed changes
then
    echo "some errors" >&2
    exit 1
fi

<<<<<<< Updated upstream
echo '- [new_g](./new_g.md)' >> ./src/SUMMARY.md
||||||| Stash base
echo '- [test01](./test01.md)' >> ./src/SUMMARY.md
=======
echo '- [Northwestern_Thesis_Proposal_Template__1_43](./Northwestern_Thesis_Proposal_Template__1_43.md)' >> ./src/SUMMARY.md
>>>>>>> Stashed changes
