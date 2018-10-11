# Test for my_dotfiles
#
# VERSION               0.1

FROM ubuntu

RUN apt-get update && apt-get install -y git curl

RUN useradd -ms /bin/bash scott
USER scott
WORKDIR /home/scott

COPY . dotfiles
WORKDIR /home/scott/dotfiles

USER root
RUN ["bash", "setup_home.sh"]

USER scott
CMD ["bash"]