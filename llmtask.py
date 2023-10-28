#!/usr/bin/env python3
import argparse
import os
import sys

import magic
import pytesseract
from dotenv import load_dotenv
from pdf2image.pdf2image import convert_from_path
from pptgpt import CreateParaphrasing

load_dotenv(".env", verbose=True, override=True)

def log(*args):
    print(*args, file=sys.stderr)

def read_txt_file(file_path):
    try:
        with open(file_path, "r") as file:
            return file.read()
    except FileNotFoundError as e:
        log(f"Error: The file '{file_path}' was not found: {e}")
    except Exception as e:
        log(f"An error occurred: {e}")
    return None


def detect_file_type(file_path):
    try:
        m = magic.Magic()
        encoded_file_type = m.from_file(file_path)
        if "text" in encoded_file_type:
            return "txt"
        elif "PDF" in encoded_file_type:
            return "pdf"
        else:
            return None
    except magic.MagicException as e:
        log(f"Error: {e}")
        sys.exit(1)


def pdf_to_images(pdf=None):
    if pdf is None:
        log("No file pdf provid")
        sys.exit(1)
    return convert_from_path(pdf)


def images_to_garbage_texts(images=None):
    if images is None:
        log("E006: can not extract images from pdf")
        sys.exit(1)
    texts = []
    num_images = len(images)
    for i in range(num_images):
        try:
            texts.append(pytesseract.image_to_string(images[i]))
            log(f"ocr image {i+1}/{num_images} ✔")
        except KeyError as e:
            log(f"ocr not found or because of {e}")

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
        log("Please provide a Pdf file.")
        sys.exit(2)

    if not os.path.exists(args.file):
        log(f"File {args.file} does not exist.")
        sys.exit(1)

    #################################################

    if args.lang is not None:
        lang = args.lang
    else:
        lang = "en"

    if not args.llm or len(args.llm) == 0:
        log("Please provide at least one task for LLM.")
        sys.exit(3)

    if not is_valid_subset(args.llm):
        raise ValueError("--llm task not included implimented tasks")

    #################################################

    file_type = detect_file_type(args.file)

    if file_type == "pdf":
        if args.ocr is None:
            log("Please provide an OCR FILEPATH.")
            sys.exit(2)
        if not os.path.exists(args.ocr):
            log(f"File {args.ocr} does not exist.")
            sys.exit(1)


        pytesseract.pytesseract.tesseract_cmd = args.ocr
        images = pdf_to_images(args.file)
        garbage_texts = images_to_garbage_texts(images)
        log("images ✔")
    elif file_type == "txt":
        garbage_texts = read_txt_file(args.file)
        log("Texts ✔")
    else:
        log("The file type is not recognized as PDF or TXT.")
        sys.exit(1)

    #################################################
    if garbage_texts is None:
        log("garbage_texts is None")
        sys.exit(1)

    lists = CreateParaphrasing(
        lang=lang,
        input_texts=garbage_texts,
        Tasks=args.llm,
        Provider=args.provider,
    ).list_tasks()

    for item in lists:
        print(item)

    ## Generate the text file
    # for item in garbage_texts:
    #     print(item)
