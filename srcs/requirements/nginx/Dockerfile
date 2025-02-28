FROM alpine:3.18    

RUN apk update && \
	apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 \
	-newkey ec -pkeyopt ec_paramgen_curve:secp384r1 \
    -nodes -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=AURA/L=Lyon/0=42/OU=42/CN=tmouche.42.fr/UID=tmouche"

RUN mkdir -p /run/nginx

# COPY conf/nginx.conf /etc/nginx/http.d/default.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf


CMD ["nginx", "-g", "daemon off;"]
