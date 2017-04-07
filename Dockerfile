FROM scratch
COPY fio /
VOLUME /config
ENTRYPOINT ["/fio"]
