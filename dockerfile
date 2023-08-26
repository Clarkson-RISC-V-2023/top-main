FROM ubuntu:latest

RUN mkdir -p /workspace
WORKDIR /workspace

RUN apt update
RUN apt upgrade -y
RUN apt install -y iverilog
RUN apt install -y gtkwave
