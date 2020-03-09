web_docker_sh   = docker exec -w /app -it app_name_web
web_docker_sh_c = $(web_docker_sh) sh -c

.DEFAULT_GOAL := up

down:
	@docker-compose down

build: down
	@docker-compose up -d --build

up: build

shell:
	@$(web_docker_sh) /bin/bash

dbshell:
	@$(web_docker_sh_c) "mysql -happ-name-db -uroot -proot app-name-db-name"

logs:
	@docker-compose logs -f --tail=100

.PHONY: down build shell up dbshell
