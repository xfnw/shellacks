FROM alpine:latest
RUN apk --no-cache add openssl zsh
WORKDIR /shellacks
ADD . /shellacks
CMD ["zsh","shellacks.sh","pissnet.cheapiesystems.com:6697","shellacks","#hamradio"]
