FROM ubuntu:latest
# FROM ubuntu:22.10

# use Morroco mirror
# RUN sed -i 's#http...archive.ubuntu.com#https://mirror.marwan.ma#' /etc/apt/sources.list
# RUN sed -i 's#^.*security.*$##' /etc/apt/sources.list
# RUN apt -o "Acquire::https::Verify-Peer=false" -o "Acquire::https::Verify-Host=false" update


# # Install apt packages
RUN apt update
RUN apt-get install -y  libmagic1
RUN apt-get install -y poppler-utils tesseract-ocr tesseract-ocr-eng tesseract-ocr-ara tesseract-ocr-fra
RUN apt-get install -y python3 python3-pip

# ORIGINAL
# COPY requirements2.txt /app/
# RUN pip3 install -r /app/requirements2.txt
COPY pptgpt-0.1.7-py3-none-any.whl /app/
RUN pip3 install /app/pptgpt-0.1.7-py3-none-any.whl -qq --ignore-installed blinker

# USER
COPY requirements.txt /app/
RUN pip3 install -r /app/requirements.txt

WORKDIR /app
