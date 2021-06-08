# set base image
FROM ubuntu:20.04
# install packages
RUN apt update && \
    apt install -y git && \
    apt install -y sudo && \
    apt install -y neovim && \
    apt install -y ansible && \
    apt install -y language-pack-en
# grant permissions
RUN useradd -m -s /bin/bash -G sudo -U fmind
RUN echo "fmind ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# define environment
USER fmind
WORKDIR /home/fmind
# define port exposes
EXPOSE 8000/tcp
EXPOSE 8888/tcp
# define mount volumes
VOLUME /home/fmind/.ssh
VOLUME /home/fmind/.gnupg
VOLUME /home/fmind/projects
# install git repository
RUN git clone --depth=1 https://github.com/fmind/dotfiles
RUN cd dotfiles && ansible-playbook -i inventory.ini site.yml --tag lite
RUN git clone --depth=1 https://github.com/fmind/devfiles
RUN cd devfiles && ansible-playbook -i inventory.ini site.yml --tag lite
# define default run command
CMD /usr/bin/byobu
