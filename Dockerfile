FROM ubuntu:18.04
MAINTAINER fmind <fmind@fmind.me>

RUN apt update && apt upgrade -y
RUN apt install -y git sudo ansible python3-pip

RUN echo "fmind ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd -rm -d /home/fmind -s /bin/bash -g root -G sudo -u 1000 fmind

USER fmind
WORKDIR /home/fmind

RUN git clone https://github.com/fmind/dotfiles dotfiles
RUN git clone https://github.com/fmind/devfiles devfiles

# RUN cd dotfiles && ansible-playbook -c local -b site.yml
# RUN cd devfiles && ansible-playbook -c local -b site.yml

# RUN apt clean && apt autoclean

# ENTRYPOINT /usr/bin/byobu
# add venv for ensure pip
# ansible-playbook -c local --become --become-user=fmind site.yml
