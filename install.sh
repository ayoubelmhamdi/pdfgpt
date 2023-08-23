#!/bin/bash

sudo xbps-install -S \
  tesseract-ocr-ara \
  tesseract-ocr-eng \
  tesseract-ocr-script-Arabic
  # tesseract-ocr-script-Arabic maybe not needed

echo pip install -r requirements.txt

echo pip install /content/pptgpt-0.1.6-py3-none-any.whl -qq --ignore-installed blinker

echo sudo DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:alex-p/tesseract-ocr5
echo sudo DEBIAN_FRONTEND=noninteractive apt update -y
echo sudo DEBIAN_FRONTEND=noninteractive apt install -y poppler-utils tesseract-ocr tesseract-ocr-eng tesseract-ocr-ara tesseract-ocr-fra
echo python3 /content/pdfgpt/pdf_to_paraphrase.py /content/2.pdf --ocr /usr/bin/tesseract 1\>res.md
