FROM alpine:latest
RUN apk add openssl zsh
WORKDIR /shellacks
ADD . /shellacks
CMD ["zsh","shellacks.sh","pissnet.cheapiesystems.com:6697","shellacks","#hamradio"]
