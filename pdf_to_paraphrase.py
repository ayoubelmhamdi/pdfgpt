#!/usr/bin/env python3
import argparse
import os
import sys

import pytesseract
from pdf2image.pdf2image import convert_from_path
from pptgpt import list_correct_text_tokenized
from pptgpt import list_correct_texts
from pptgpt import list_of_splits_to_paraphrase

# from pdf2image import convert_from_path

# from pptgpt import list_correct_ppt_jsons
# from pptgpt import list_garbage_json
# from pptgpt import list_garbage_texts
# from pptgpt import write_correct_ppt_jsons

from dotenv import load_dotenv
load_dotenv(".env")




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
        print(f"{i}/{num_images}", file=sys.stderr)
        texts.append(pytesseract.image_to_string(images[i]))

    if len(texts) == 0:
        sys.exit(1)
    return texts


def garbage_texts_to_correct_texts(garbage_texts):
    if garbage_texts is None:
        print("E007: can not extract text from pdf/image", file=sys.stderr)
        sys.exit(1)
    return list_correct_texts(garbage_texts)


def correct_text_to_tokenized(correct_texts):
    # correct_texts = pdf_correct_texts(pdf_binary)
    # correct_texts = [
    #     "# H1\nAyoub",
    #     "# H2\n## h1\n Long text",
    # ]
    if correct_texts is None:
        print(
            "E008: OPENAI can not return correct_texts",
            file=sys.stderr,
        )
        sys.exit(1)

    correct_text_str = ""
    for text in correct_texts:
        correct_text_str += text
    return list_correct_text_tokenized(correct_text_str)


def correct_texts_to_paraphrases(tokenizeds):
    if correct_texts is None:
        print(
            "E008: lang-chain can not tokenized the correct texts",
            file=sys.stderr,
        )
        sys.exit(1)

    return list_of_splits_to_paraphrase(tokenizeds)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Paraphrasing a PDF file using API")
    parser.add_argument("file", type=str, help="Path to PDF file")
    parser.add_argument("-o", "--ocr", type=str, help="The ocr FILE_PATH")

    args = parser.parse_args(sys.argv[1:])

    if not os.path.exists(args.file):
        print(f"File {args.file} does not exist.")
        sys.exit(1)

    if args.file is None:
        print("Please provide a Pdf file.")
        sys.exit(2)

    if args.ocr is None:
        print("Please provide a ocr FILEPATH.")
        sys.exit(2)



    pdf = args.file
    ocr_path = args.ocr
    pytesseract.pytesseract.tesseract_cmd = ocr_path

    images = pdf_to_images(pdf)
    import os
    print(os.getenv("OPENAI_API_KEY"))
    #print(images)
    sys.exit(0)
    garbage_texts = images_to_garbage_texts(images)
    correct_texts = garbage_texts_to_correct_texts(garbage_texts)

    if correct_texts is not None:
        total_pages = len(correct_texts)
        for i, page in enumerate(correct_texts):
            print(
                f"test {i}/{total_pages}",
                file=sys.stderr,
            )
            print(page, "\n\n")
        print("\n# ---------------\n")

    tokenizeds = correct_text_to_tokenized(correct_texts)
    paraphrases = correct_texts_to_paraphrases(tokenizeds)

    if paraphrases is not None:
        total_chnks = len(paraphrases)
        for i, chunk in enumerate(paraphrases):
            print(
                f"chunk {i}/{total_chnks}",
                file=sys.stderr,
            )
            print(chunk, "\n\n")
    else:
        print(
            "E005:  OPENAI can not return paraphrasing",
            file=sys.stderr,
        )
