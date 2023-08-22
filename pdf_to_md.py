#!/usr/bin/env python3
import sys

import pytesseract
from pdf2image import convert_from_path
from pptgpt import list_correct_texts

# from pptgpt import list_garbage_json
# from pptgpt import list_garbage_texts
# from pptgpt import list_correct_ppt_jsons
# from pptgpt import write_correct_ppt_jsons


pytesseract.pytesseract.tesseract_cmd = r"/usr/bin/tesseract-ocr"


def pdf_to_images(pdf=None):
    if pdf is None:
        print("No file pdf provid", file=sys.stderr)
        return None
    return convert_from_path(pdf)


def images_to_garbage_texts(images=None):
    if images is None:
        print("E006: can not extract images from pdf", file=sys.stderr)
        return None
    texts = []
    num_images = len(images)
    for i in range(num_images):
        print(f"{i}/{num_images}", file=sys.stderr)
        texts.append(pytesseract.image_to_string(images[i]))

    if len(texts) == 0:
        return None
    return texts


def garbage_texts_to_correct_texts(garbage_texts):
    if garbage_texts is None:
        print("E007: can not extract text from pdf/image", file=sys.stderr)
        return None
    return list_correct_texts(garbage_texts)


if __name__ == "__main__":
    pdf = "/tmp/2.pdf"
    images = pdf_to_images(pdf)
    garbage_texts = images_to_garbage_texts(images)
    correct_texts = garbage_texts_to_correct_texts(garbage_texts)

    if correct_texts is not None:
        for text in correct_texts:
            print(text, "\n\n")
    else:
        print("E008: OPENAI can not return correct_texts", file=sys.stderr)
