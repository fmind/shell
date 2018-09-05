FROM ubuntu:latest

MAINTAINER fmind <dev@fmind.me>

RUN apt update && apt upgrade -y

RUN apt install -y git ansible python3-pip

RUN git clone https://git.fmind.me/fmind/dotfiles dotfiles

RUN cd dotfiles && ansible-playbook -i 'localhost,' -c local site.yml

RUN pip3 install xonsh[ptk,linux]

RUN apt clean && apt autoclean

ENTRYPOINT /usr/bin/xonsh
