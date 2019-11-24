FROM debian:10

RUN apt-get update \
 && apt-get install -y sudo curl zsh wget git tmux vim build-essential python3-pip python3-dev \
 && cd /usr/local/bin \
 && ln -s /usr/bin/python3 python \
 && pip3 install --upgrade pip

COPY . .
RUN pip install -r requirements.txt
RUN python nltk_setup.py

WORKDIR /home