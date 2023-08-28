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
        print(f"ocr image {i+1}/{num_images} ✔", file=sys.stderr)
        texts.append(pytesseract.image_to_string(images[i]))

    if len(texts) == 0:
        sys.exit(1)
    return texts


def is_valid_subset(user_args):
    # Convert both arrays (or sets) to sets for faster lookup
    user_args = set(user_args)
    tasks = ["correct_ocr", "paraphrasing", "child", "ppt"]
    for item in user_args:
        if item not in tasks:
            return False
    return True


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Paraphrasing a PDF file using API")
    parser.add_argument("-o", "--ocr", type=str, help="The ocr FILE_PATH")
    parser.add_argument("-l", "--lang", type=str, help="The langague of PDF")
    parser.add_argument(
        "--llm", type=str, action="extend", nargs="+", help="Task for LLM"
    )
    parser.add_argument("--file", type=str, help="Path to PDF file")

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
        lang = "en"

    if not args.llm:
        print("Please provide at least one task for LLM.", file=sys.stderr)
        sys.exit(3)
    
    if not is_valid_subset(args.llm):
        raise ValueError("--llm not include in taks that implemented")

    #################################################

    pdf = args.file
    ocr_path = args.ocr
    pytesseract.pytesseract.tesseract_cmd = ocr_path

    #################################################

    images = pdf_to_images(pdf)
    garbage_texts = images_to_garbage_texts(images)
    print("images ✔", file=sys.stderr)

    #################################################

    # TODO: use open with to store to src/file.pdf.garbage.md
    # TODO: paraphrasing to src/file.pdf.paraphrasing.md

    # print("# -------- GARBAGE TEXT -------\n")
    # for page in garbage_texts:
    #     print(page, "\n\n")
    # print("Garbage_texts ✔", file=sys.stderr)
    # print("# -------- LLM TEXTS -------\n")
    # # sys.exit(0)

    #################################################

    lists = CreateParaphrasing(
        lang=lang,
        input_texts=garbage_texts,
        Tasks=args.llm,  # "child"],
    ).list_tasks()

    for item in lists:
        print(item)
