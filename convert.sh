#!/bin/bash

set -x

# initialise the TMPDIR with tmp if not initalise yet.
: "${TMPDIR:=/tmp}"

<<<<<<< Updated upstream
tmp_name="$TMPDIR/new_e.pdf"
||||||| Stash base
tmp_name="$TMPDIR/Northwestern_Thesis_Proposal_Template__1_ (43).pdf"
=======
tmp_name="$TMPDIR/test01.pdf"
>>>>>>> Stashed changes
rm -f "$tmp_name"

<<<<<<< Updated upstream
if ! wget -q --output-document "$tmp_name" "https://bashupload.com/a9Z7X/new_e.pdf";then
||||||| Stash base
if ! wget -q --output-document "$tmp_name" "https://bashupload.com/322Wr/QKQkv.pdf";then
=======
if ! wget -q --output-document "$tmp_name" "https://bashupload.com/WzW4P/test01.pdf";then
>>>>>>> Stashed changes
  echo "Can not use wget to download this file."
  exit 1
fi

clear

if ! python3 llmtask.py                \
    --ocr /usr/bin/tesseract           \
    --lang fr                          \
    --llm correct_ocr  \
    --file "$tmp_name"                 \
<<<<<<< Updated upstream
    --provider Aivvm                   \
    1> './src/new_e.md'
||||||| Stash base
    1> './src/Northwestern_Thesis_Proposal_Template__1_ (43).md'
=======
    1> './src/test01.md'
>>>>>>> Stashed changes
then
    echo "some errors" >&2
    exit 1
fi

<<<<<<< Updated upstream
echo '- [new_e](./new_e.md)' >> ./src/SUMMARY.md
||||||| Stash base
echo '- [Northwestern_Thesis_Proposal_Template__1_ (43)](./Northwestern_Thesis_Proposal_Template__1_ (43).md)' >> ./src/SUMMARY.md
=======
echo '- [test01](./test01.md)' >> ./src/SUMMARY.md
>>>>>>> Stashed changes
