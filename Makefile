all: up

up:
	@mkdir -p ~/data
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb
	docker compose -f srcs/docker-compose.yml up --build

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
	rm -rf ~/data

re: fclean up

.PHONY: all up build down start stop logs prune mariadb re fclean clean