FROM ubuntu:focal

RUN apt-get update && \
    apt-get install -y build-essential autoconf bison gawk ninja-build python3 \
                       python3-click python3-jinja2 wget curl libcurl4-openssl-dev \
                       libprotobuf-c-dev protobuf-c-compiler python3-venv git pkgconf nasm python3-protobuf protobuf-compiler python3-cryptography nano sqlite3 unzip linux-tools-generic && \
    apt-get clean

RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
python3 /tmp/get-pip.py && \
rm -rf /tmp/* && \
pip3 install --upgrade setuptools && \
pip3 install 'toml>=0.10' 'meson>=0.55' protobuf pyelftools

WORKDIR /root

RUN wget https://github.com/gramineproject/gramine/archive/refs/tags/v1.3.1.zip && \
    unzip v1.3.1.zip && \
    mv gramine-1.3.1 gramine && \
    rm -f v1.3.1.zip

WORKDIR /root/gramine
RUN mkdir -p ./driver/asm && wget -O ./driver/asm/sgx.h https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/arch/x86/include/uapi/asm/sgx.h?h=v5.15
RUN meson setup build/ --buildtype=debugoptimized -Ddirect=enabled -Dsgx=enabled -Dsgx_driver=upstream -Dsgx_driver_include_path=/root/gramine/driver
RUN ninja -v -C build/
RUN ninja -C build/ install

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PYTHONPATH=/usr/local/lib/python3.8/site-packages
