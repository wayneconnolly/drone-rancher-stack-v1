FROM alpine
RUN apk update && apk add tar wget git ca-certificates && rm -rf /var/cache/apk/*
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
RUN wget https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.gz
RUN tar -zxvf rancher-compose-linux* && mv rancher-compose-*/rancher-compose /bin/. && chmod +x /bin/rancher-compose
ENTRYPOINT /bin/script.sh
