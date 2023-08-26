FROM ubuntu:latest

RUN mkdir -p /workspace
WORKDIR /workspace

RUN apt update
RUN apt upgrade -y
RUN apt install -y iverilog
RUN apt install -y gtkwave
RUN apt install -y tree
RUN apt install -y git
RUN git clone --recurse-submodules git@github.com:Clarkson-RISC-V-2023/top-main.git
RUN tree