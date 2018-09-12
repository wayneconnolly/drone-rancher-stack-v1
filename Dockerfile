FROM alpine
RUN apk update && apk add tar wget git ca-certificates && rm -rf /var/cache/apk/*
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
RUN wget https://github.com/rancher/cli/releases/download/v0.6.11/rancher-linux-amd64-v0.6.11.tar.gz
RUN tar -zxvf rancher-linux* && mv rancher-*/rancher /bin/. && chmod +x /bin/rancher
ENTRYPOINT /bin/script.sh
