FROM alpine
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
RUN apk -Uuv add curl tar ca-certificates
ENTRYPOINT /bin/script.sh
