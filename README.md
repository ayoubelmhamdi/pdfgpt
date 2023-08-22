# Incomplet setup

- `pptgpt` is local `repo` that has many stupide function to return result from OpenAI.

- need `tesseract` binary
- need install `tesseract-ocr-eng` languages in `/usr/share/tessdata/eng.traineddata`

```py
import pytesseract
from pdf2image import convert_from_path
from pptgpt import list_correct_texts

pytesseract.pytesseract.tesseract_cmd = r"/usr/bin/tesseract-ocr"
```
