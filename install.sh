#!/bin/bash

sudo xbps-install -S \
  tesseract-ocr-ara \
  tesseract-ocr-eng \
  tesseract-ocr-script-Arabic
  # tesseract-ocr-script-Arabic maybe not needed

echo pip install -r requirements.txt
