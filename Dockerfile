FROM alpine
ADD script.sh /bin/
RUN curl -o rancher-compose.tar.gz https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.gz
RUN chmod +x /bin/script.sh
RUN apk -Uuv add curl tar ca-certificates
ENTRYPOINT /bin/script.sh
