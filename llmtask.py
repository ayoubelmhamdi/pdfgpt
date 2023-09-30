#!/usr/bin/env python3
import argparse
import mimetypes
import os
import sys

import magic
import pytesseract
from dotenv import load_dotenv
from pdf2image.pdf2image import convert_from_path
from pptgpt import CreateParaphrasing

load_dotenv(".env", verbose=True, override=True)


def read_txt_file(file_path):
    try:
        with open(file_path, "r") as file:
            return file.read()
    except FileNotFoundError as e:
        print(f"Error: The file '{file_path}' was not found: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")
    return None


def detect_file_type(file_path):
    try:
        m = magic.Magic()
        encoded_file_type = m.from_file(file_path)
        if "ASCII text" in encoded_file_type:
            return "txt"
        elif "PDF" in encoded_file_type:
            return "pdf"
        else:
            return None
    except magic.MagicException as e:
        print(f"Error: {e}")
        sys.exit(1)


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
        try:
            texts.append(pytesseract.image_to_string(images[i]))
            print(f"ocr image {i+1}/{num_images} ✔", file=sys.stderr)
        except KeyError as e:
            print(f"ocr not found or because of {e}", file=sys.stderr)

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
    parser.add_argument("--provider", type=str, help="The Provider for free GPT")
    parser.add_argument("--file", type=str, help="Path to input file")

    args = parser.parse_args(sys.argv[1:])

    if args.file is None:
        print("Please provide a Pdf file.", file=sys.stderr)
        sys.exit(2)

    if not os.path.exists(args.file):
        print(f"File {args.file} does not exist.", file=sys.stderr)
        sys.exit(1)

    #################################################

    if args.lang is not None:
        lang = args.lang
    else:
        lang = "en"

    if not args.llm or len(args.llm) == 0:
        print("Please provide at least one task for LLM.", file=sys.stderr)
        sys.exit(3)

    if not is_valid_subset(args.llm):
        raise ValueError("--llm task not included implimented tasks")

    #################################################

    file_type = detect_file_type(args.file)

    if file_type == "pdf":
        if args.ocr is None:
            print("Please provide an OCR FILEPATH.", file=sys.stderr)
            sys.exit(2)

        pytesseract.pytesseract.tesseract_cmd = args.ocr
        images = pdf_to_images(args.file)
        garbage_texts = images_to_garbage_texts(images)
        print("images ✔", file=sys.stderr)
    elif file_type == "txt":
        garbage_texts = read_txt_file(args.file)
        print("Texts ✔", file=sys.stderr)
    else:
        print("The file type is not recognized as PDF or TXT.", file=sys.stderr)
        sys.exit(1)

    #################################################
    if garbage_texts is None:
        print("garbage_texts is None", file=sys.stderr)
        sys.exit(1)

    lists = CreateParaphrasing(
        lang=lang,
        input_texts=garbage_texts,
        Tasks=args.llm,
        Provider=args.provider,
    ).list_tasks()

    for item in lists:
        print(item)
