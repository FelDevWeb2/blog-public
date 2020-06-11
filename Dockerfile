FROM ghost:3-alpine

EXPOSE 8080

RUN set -eux; \
    cd "$GHOST_INSTALL"; \
	su-exec node ghost config --ip 0.0.0.0 --port 8080 --no-prompt --db sqlite3 --url http://localhost:8080 --dbpath "$GHOST_CONTENT/data/ghost.db";

FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY site.template /etc/nginx/conf.d/site.template
CMD /bin/bash -c "envsubst < /etc/nginx/conf.d/site.template > /etc/nginx/conf.d/site.conf && exec nginx -g 'daemon off;'"