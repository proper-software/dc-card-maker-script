FROM debian:jessie

RUN apt-get update
RUN apt-get install --assume-yes build-essential cmake protobuf-compiler git genisoimage bsdmainutils unzip

WORKDIR /app

RUN git clone https://github.com/Kazade/img4dc /app/tools/img4dc
RUN cmake /app/tools/img4dc
RUN make --directory=/app

RUN git clone https://github.com/proper-software/cdirip.git /app/tools/cdirip
RUN make --directory=/app/tools/cdirip -f Makefile.linux

COPY ./data /app/data
COPY ./ini /app/ini
COPY ./tools /app/tools
COPY ./dc-card-maker.sh /app

RUN cd /app/tools && ls -halt
RUN cd /app/tools/cdirip && ls -halt
RUN cd /app/tools/img4dc && ls -halt

CMD [ "/app/dc-card-maker.sh" ]
