FROM nginx:1.31.4-alpine@sha256:db35bfc6b2951e7f8a72db5db120288c127ffaeeb4a6d4b95a26fead017d5913

ARG PORT=8080
ENV PORT=${PORT}

RUN apk upgrade --no-cache && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Strip setuid / setgid bits from every file on the image filesystem
RUN find / -xdev \( -perm -4000 -o -perm -2000 \) -exec chmod a-s {} + 2>/dev/null || true

# Prepare writable runtime directories for the unprivileged nginx user
RUN install -d -m 0750 -o nginx -g nginx \
        /var/cache/nginx/client_temp \
        /var/cache/nginx/proxy_temp \
        /var/cache/nginx/fastcgi_temp \
        /var/cache/nginx/uwsgi_temp \
        /var/cache/nginx/scgi_temp && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid

# Install the hardened nginx configuration (owned by root, readable by all)
COPY nginx.conf /etc/nginx/nginx.conf
RUN sed -i "s/listen      8080;/listen      ${PORT};/" /etc/nginx/nginx.conf && \
    chmod 444 /etc/nginx/nginx.conf

# Install static content with read-only permissions
COPY --chown=nginx:nginx index.html /usr/share/nginx/html/index.html
RUN chmod 444 /usr/share/nginx/html/index.html && \
    chmod 555 /usr/share/nginx/html

# Drop to non-root for all subsequent layers and at runtime
USER nginx

EXPOSE ${PORT}

STOPSIGNAL SIGQUIT

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD wget -qO /dev/null http://127.0.0.1:${PORT}/ || exit 1

CMD ["nginx", "-g", "daemon off;"]