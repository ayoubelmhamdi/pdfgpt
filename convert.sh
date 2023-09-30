#!/bin/bash

set -x


# if ! python3 llmtask.py                \
#     --lang fr                          \
#     --llm correct_ocr                  \
#     --file "/tmp/1.txt"                \
#     --provider Aivvm
# then
#     echo "some errors" >&2
#     exit 1
# fi

"${0%/*}/aiivm2.py"

