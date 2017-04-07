FROM scratch
COPY fio /
VOLUME /config
WORKDIR /config
ENV VOL /v
ENTRYPOINT ["/fio"]
