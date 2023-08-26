FROM ubuntu:latest

ARG ssh_pub
ARG ssh_prv

RUN mkdir -p /workspace
WORKDIR /workspace

RUN apt update && \
    apt upgrade -y && \
    apt install -y iverilog tree git ssh vim && \
    mkdir -p ~/.ssh
# COPY ${ssh_prv} ~/.ssh/id_rsa
RUN touch ~/.ssh/id_rsa.pub 
RUN echo ${ssh_pub} > ~/.ssh/id_rsa.pub \
    chmod 600 ~/.ssh/id_rsa \
    chmod 600 ~/.ssh/id_rsa.pub 
RUN git clone --recurse-submodules git@github.com:Clarkson-RISC-V-2023/top-main.git \
    tree