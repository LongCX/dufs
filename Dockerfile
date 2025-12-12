FROM sigoden/dufs AS src

FROM alpine:latest AS tz
RUN apk add --no-cache tzdata

# Health
FROM 11notes/distroless:localhealth AS distroless-localhealth

FROM scratch
COPY --chown=65532:65532 --from=src /bin/dufs /app/dufs
COPY --chown=65532:65532 --from=tz /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
COPY --chown=65532:65532 --from=distroless-localhealth / /

EXPOSE 6970

HEALTHCHECK --interval=120s --timeout=2s --start-period=5s \
  CMD ["/usr/local/bin/localhealth", "http://127.0.0.1:6970/__dufs__/health"]

USER 65532:65532

ENTRYPOINT ["/app/dufs"]
