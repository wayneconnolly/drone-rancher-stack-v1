FROM alpine
RUN apk update && apk -Uuv add curl tar ca-certificates && rm -rf /var/cache/apk/*
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
RUN curl -o rancher-compose.tar.gz https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.gz
ENTRYPOINT /bin/script.sh
