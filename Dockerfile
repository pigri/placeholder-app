FROM nginx:alpine

ENV PORT=80
RUN apk --no-cache upgrade && apk --no-cache add wget

ADD default.conf.template /etc/nginx/conf.d/default.conf.template
ADD index.html /usr/share/nginx/html/index.html

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD wget -q -O - http://localhost:${PORT}/status/healthz || exit 1

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh", "-c", "pwd; nginx -g 'daemon off;'"]
