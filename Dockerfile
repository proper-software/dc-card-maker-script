FROM debian:jessie

RUN apt-get update
RUN apt-get install --assume-yes build-essential cmake protobuf-compiler git genisoimage bsdmainutils unzip

WORKDIR /app

RUN git clone https://github.com/Kazade/img4dc /app/tools/img4dc
RUN git clone https://github.com/proper-software/cdirip.git /app/tools/cdirip

RUN cd /app/tools/img4dc && cmake . && make
RUN cd /app/tools/cdirip && make -f Makefile.linux

COPY ./data /app/data
COPY ./ini /app/ini
COPY ./tools /app/tools
COPY ./dc-card-maker.sh /app 

CMD [ "/app/dc-card-maker.sh" ]
