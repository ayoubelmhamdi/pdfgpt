#!/usr/bin/env python3
import argparse
import os
import sys

import pytesseract
from dotenv import load_dotenv
from pdf2image.pdf2image import convert_from_path
from pptgpt import CreateParaphrasing

load_dotenv(".env", verbose=True, override=True)


def pdf_to_images(pdf=None):
    if pdf is None:
        print("No file pdf provid", file=sys.stderr)
        sys.exit(1)
    return convert_from_path(pdf)


def images_to_garbage_texts(images=None):
    if images is None:
        print("E006: can not extract images from pdf", file=sys.stderr)
        sys.exit(1)
    texts = []
    num_images = len(images)
    for i in range(num_images):
        print(f"image {i+1}/{num_images}", file=sys.stderr)
        texts.append(pytesseract.image_to_string(images[i]))

    if len(texts) == 0:
        sys.exit(1)
    return texts


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Paraphrasing a PDF file using API")
    parser.add_argument("file", type=str, help="Path to PDF file")
    parser.add_argument("-o", "--ocr", type=str, help="The ocr FILE_PATH")
    parser.add_argument("-l", "--lang", type=str, help="The langague of PDF")

    args = parser.parse_args(sys.argv[1:])

    if not os.path.exists(args.file):
        print(f"File {args.file} does not exist.", file=sys.stderr)
        sys.exit(1)

    if args.file is None:
        print("Please provide a Pdf file.", file=sys.stderr)
        sys.exit(2)

    if args.ocr is None:
        print("Please provide a ocr FILEPATH.", file=sys.stderr)
        sys.exit(2)

    if args.lang is not None:
        lang = args.lang
    else:
        lang = "En"

    pdf = args.file
    ocr_path = args.ocr

    pytesseract.pytesseract.tesseract_cmd = ocr_path

    #############################################################

    images = pdf_to_images(pdf)
    garbage_texts = images_to_garbage_texts(images)
    print("images ✔", file=sys.stderr)

    # TODO: use open with to store to src/file.pdf.garbage.md
    # TODO: paraphrasing to src/file.pdf.paraphrasing.md
    # print("# -------- GARBAGE TEXT -------\n")
    # for page in garbage_texts:
    #     print(page, "\n\n")
    print("Garbage_texts ✔", file=sys.stderr)

    #############################################################
    paraphrases = (
        CreateParaphrasing(
            lang=lang,
            garbage_texts=garbage_texts,
        )
        .list_correct_texts()
        .correct_text_to_tokenized()
        .list_of_splits_to_paraphrase()
    )

    print("\n# -------- PARAPHRASSING TEXT -------\n")
    total_chnks = len(paraphrases)
    for i, chunk in enumerate(paraphrases):
        print(f"chunk {i+1}/{total_chnks} ✔", file=sys.stderr)
        print(chunk, "\n\n")
