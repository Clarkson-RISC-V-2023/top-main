FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN apt update && apt upgrade -y
RUN apt install -y ssh wget tree vim git build-essential g++ bison flex gperf libreadline-dev libncurses5-dev autoconf
RUN mkdir -p workspace \ 
    cd workspace 
WORKDIR /workspace
RUN git clone https://github.com/steveicarus/iverilog.git && \
    cd iverilog && \
    sh autoconf.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf iverilog
RUN apt install -y gtkwave
RUN ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N ""
RUN rm -rf /root/.ssh/id_rsa.pub && \
    rm -rf /root/.ssh/id_rsa && \   
    touch /root/.ssh/id_rsa.pub && \
    touch /root/.ssh/id_rsa
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub
COPY known_hosts /root/.ssh/known_hosts
RUN chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub
RUN git clone --recurse-submodules git@github.com:Clarkson-RISC-V-2023/top-main.git && \
    cd top-main && \
    tree
WORKDIR /workspace/top-main