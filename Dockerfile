FROM fedora:latest

ENTRYPOINT /usr/bin/zsh

RUN dnf install -y git ansible

RUN git clone https://github.com/fmind/dotfiles .dotfiles

RUN cd .dotfiles && ansible-galaxy install --force -r role.yml

RUN cd .dotfiles && ansible-playbook -i 'localhost,' -c local site.yml

RUN usermod -s /usr/bin/zsh root

RUN dnf -y update

RUN dnf clean all
