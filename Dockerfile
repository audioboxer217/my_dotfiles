# Test for my_dotfiles
#
# VERSION               0.1

FROM ubuntu

RUN apt-get update && apt-get install -y git curl wget sudo zip

RUN useradd -ms /bin/bash scott
RUN usermod -aG sudo scott
RUN echo 'scott:changeme' | chpasswd
RUN echo 'scott ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY --chown=scott . /home/scott/dotfiles
USER scott
RUN ["sudo", "/home/scott/dotfiles/setup_home.sh"]

WORKDIR /home/scott
CMD ["bash"]
