FROM ubuntu:18.04

RUN apt update
RUN apt install -y git && \
    apt install -y sudo && \
    apt install -y neovim && \
    apt install -y ansible && \
    apt install -y language-pack-en

RUN useradd -m -s /bin/bash -G sudo -U fmind && \
    echo "fmind ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER fmind

WORKDIR /home/fmind

RUN git clone --depth=1 https://github.com/fmind/dotfiles
RUN cd dotfiles && ansible-playbook -i inventory.ini site.yml

RUN git clone --depth=1 https://github.com/fmind/devfiles
RUN cd devfiles && ansible-playbook -i inventory.ini site.yml

ENTRYPOINT /bin/bash
