FROM ubuntu:latest

ARG ssh_pub
ARG ssh_prv

RUN mkdir -p /workspace
WORKDIR /workspace

RUN apt update
RUN apt upgrade -y
RUN apt install -y iverilog
RUN apt install -y gtkwave
RUN apt install -y tree
RUN apt install -y git
RUN apt install -y ssh
RUN apt install -y vim
RUN mkdir -p ~/.ssh
RUN echo ${ssh_prv} > ~/.ssh/id_rsa
RUN echo ${ssh_pub} > ~/.ssh/id_rsa.pub
RUN chmod 600 ~/.ssh/id_rsa
RUN chmod 600 ~/.ssh/id_rsa.pub
RUN git clone --recurse-submodules git@github.com:Clarkson-RISC-V-2023/top-main.git
RUN tree