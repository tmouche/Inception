all: up

up: secrets
	@mkdir -p ~/data
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb
	docker compose -f srcs/docker-compose.yml up --build --detach

build:
	docker compose -f srcs/docker-compose.yml build --no-cache

down:
	docker compose -f srcs/docker-compose.yml down

start:
	docker compose -f srcs/docker-compose.yml start

stop:
	docker compose -f srcs/docker-compose.yml stop

logs:
	docker compose -f srcs/docker-compose.yml logs --follow

prune:
	docker system prune --all --volumes --force

mariadb:
	docker compose -f srcs/docker-compose.yml exec mariadb mariadbd

clean:
	docker compose -f srcs/docker-compose.yml down --volumes --rmi all

fclean: clean
#	Use docker run to remove data because of permissions
	docker run -it --rm -v $(HOME)/data:/data busybox sh -c "rm -rf /data/*"
	rm -rf ./secrets/

re: fclean up

secrets:
	@mkdir -p $@
	openssl rand -hex -out $@/db_root_password 16
	openssl rand -hex -out $@/db_password 16
	openssl rand -hex -out $@/wp_admin_password 16
	openssl rand -hex -out $@/wp_password 16
	openssl req -x509 -newkey rsa:2048 -keyout $@/ssl_certificate_key -out $@/ssl_certificate -days 365 -nodes -subj "/CN=tmouche.42.fr" 2> /dev/null

.PHONY: all up build down start stop logs prune mariadb re fclean clean