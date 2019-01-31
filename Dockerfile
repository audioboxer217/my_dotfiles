# Test for my_dotfiles
#
# VERSION               0.1

FROM ubuntu

RUN apt-get update && apt-get install -y git curl wget sudo zip

RUN useradd -ms /bin/bash scott
WORKDIR /home/scott

COPY --chown=scott . dotfiles
WORKDIR /home/scott/dotfiles

RUN ["bash", "setup_home.sh"]

USER scott
WORKDIR /home/scott
CMD ["bash"]
