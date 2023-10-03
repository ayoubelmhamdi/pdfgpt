# Use an official Ubuntu as a parent image
FROM ubuntu:latest
# FROM ubuntu:22.10

# use Morroco mirror
# RUN sed -i 's#http...archive.ubuntu.com#https://mirror.marwan.ma#' /etc/apt/sources.list
# RUN sed -i 's#^.*security.*$##' /etc/apt/sources.list
# RUN apt -o "Acquire::https::Verify-Peer=false" -o "Acquire::https::Verify-Host=false" update


# # Install apt packages
RUN apt update
RUN apt-get install -y  libmagic1 poppler-utils tesseract-ocr tesseract-ocr-eng tesseract-ocr-ara tesseract-ocr-fra

# Install Python and pip
RUN apt-get install -y python3 python3-pip
#
# # Install your Python packages
COPY requirements.txt /app/
COPY pptgpt-0.1.8-py3-none-any.whl /app/

RUN pip3 install -r /app/requirements.txt
RUN pip3 install /app/pptgpt-0.1.8-py3-none-any.whl -qq --ignore-installed blinker

# Set the working directory
WORKDIR /app
