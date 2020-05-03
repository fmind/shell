FROM ubuntu:20.04

RUN apt update && \
    apt install -y git && \
    apt install -y sudo && \
    apt install -y neovim && \
    apt install -y ansible && \
    apt install -y language-pack-en

RUN useradd -m -s /bin/bash -G sudo -U fmind && \
    echo "fmind ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER fmind

WORKDIR /home/fmind

VOLUME /home/fmind/code

RUN git clone --depth=1 https://github.com/fmind/dotfiles && \
    cd dotfiles && ansible-playbook -i inventory.ini site.yml

RUN git clone --depth=1 https://github.com/fmind/devfiles && \
    cd devfiles && ansible-playbook -i inventory.ini site.yml

CMD /usr/bin/byobu
