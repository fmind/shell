# set base image
FROM ubuntu:20.04
# install packages
RUN apt update && \
    apt install -y git && \
    apt install -y sudo && \
    apt install -y neovim && \
    apt install -y ansible && \
    apt install -y language-pack-en
# grant sudo permissions
RUN useradd -m -s /bin/bash -G sudo -U fmind && \
    echo "fmind ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# define user environment
USER fmind
WORKDIR /home/fmind
# define container exposes
EXPOSE 8888/tcp
# define container volumes
VOLUME /home/fmind/.ssh
VOLUME /home/fmind/.gnupg
VOLUME /home/fmind/projects
# install my git repository
RUN git clone --depth=1 https://github.com/fmind/dotfiles && \
    cd dotfiles && ansible-playbook -i inventory.ini site.yml
RUN git clone --depth=1 https://github.com/fmind/devfiles && \
    cd devfiles && ansible-playbook -i inventory.ini site.yml
# define default run command
CMD /usr/bin/zsh
