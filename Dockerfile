FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y libssl-dev build-essential git autoconf automake libtool libcurl4 m4 vim autoconf-archive pkgconf libjson-c-dev libcurl4-openssl-dev uuid-dev
RUN apt-get install -y python3 pip && pip install signify

# build and install tss lib
RUN git clone https://github.com/tpm2-software/tpm2-tss.git && cd tpm2-tss && ./bootstrap && \
    ./configure  --prefix=/usr --disable-doxygen-doc && make -j && make install && \
    echo "/usr/lib" > /etc/ld.so.conf.d/tss.conf && ldconfig

# build and install tpm2 tools
RUN git clone https://github.com/tpm2-software/tpm2-tools && cd tpm2-tools && ./bootstrap && \
    ./configure  --prefix=/usr && make -j && make install

# install tpm_futurepcr
RUN git clone https://github.com/grawity/tpm_futurepcr.git && cd tpm_futurepcr && python3 setup.py install
