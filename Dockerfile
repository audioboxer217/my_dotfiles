FROM ubuntu:16.04

ARG USER=scott

RUN apt-get update && apt-get install -y vim tmux git apt-transport-https gnupg2 curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -y kubectl && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash $USER
RUN usermod -aG sudo $USER
RUN echo "$USER:changeme" | chpasswd
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY --chown=$USER . /home/$USER/dotfiles
USER $USER
WORKDIR /home/$USER/dotfiles
RUN ["/bin/bash", "./setup_vim-tmux.sh"]

CMD ["/bin/bash"]
