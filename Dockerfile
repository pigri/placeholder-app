FROM nginx:alpine

ENV PORT=80
RUN apk --no-cache upgrade

ADD default.conf.template /etc/nginx/conf.d/default.conf.template
ADD index.html /usr/share/nginx/html/index.html

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh", "-c", "pwd; nginx -g 'daemon off;'"]
