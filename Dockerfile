FROM ubuntu:18.04
MAINTAINER fmind <fmind@fmind.me>

RUN apt update && \ 
    apt upgrade -y && \
    apt install -y git && \
    apt install -y sudo && \
    apt install -y ansible

RUN useradd -m -U -s /bin/bash -G sudo fmind && \\
    echo "fmind ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER fmind
WORKDIR /home/fmind

RUN git clone --depth=1 https://github.com/fmind/devfiles devfiles
RUN git clone --depth=1 https://github.com/fmind/dotfiles dotfiles

RUN cd dotfiles && ansible-playbook -c local -b --become-user=fmind site.yml
RUN cd devfiles && ansible-playbook -c local -b --become-user=fmind site.yml

RUN apt clean && apt autoclean

# ENTRYPOINT /usr/bin/byobu
# ansible-playbook -c local --become --become-user=fmind site.yml
