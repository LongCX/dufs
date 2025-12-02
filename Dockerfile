FROM sigoden/dufs AS src

FROM gcr.io/distroless/cc-debian12:nonroot
COPY --chown=nonroot:nonroot --from=src /bin/dufs /app/dufs

USER nonroot
VOLUME ["/config"]
ENV TZ=Asia/Ho_Chi_Minh

ENTRYPOINT ["/app/dufs"]