FROM sigoden/dufs AS src

FROM alpine:latest AS tz
RUN apk add --no-cache tzdata

FROM scratch
COPY --chown=65532:65532 --from=src /bin/dufs /app/dufs
COPY --chown=65532:65532 --from=tz /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime

VOLUME ["/config"]

USER 65532:65532

ENTRYPOINT ["/app/dufs"]
