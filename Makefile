all: up

up:
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

prune:
	docker system prune -a

clean:
	docker compose -f srcs/docker-compose.yml down --volumes --rmi all

fclean: clean
	sudo rm -rf /home/thibaud/data

re: fclean up

.PHONY: all up build down start stop prune re fclean clean
