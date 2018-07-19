FROM ubuntu:latest

MAINTAINER fmind <dev@fmind.me>

RUN apt update && apt upgrade -y

RUN apt install -y git ansible python3-pip

RUN GIT_SSL_NO_VERIFY=true git clone https://git.fmind.me/fmind/dotfiles dotfiles

RUN cd dotfiles && ansible-playbook -i 'localhost,' -c local site.yml

RUN usermod -s /usr/bin/zsh root

RUN apt clean && apt autoclean

ENTRYPOINT /usr/bin/zsh
