web_docker_sh   = docker exec -w /app -it d8-boilerplate_web_1
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
	@$(web_docker_sh_c) "mysql -hd8-boilerplate_db_1 -uroot -proot app_db"

logs:
	@docker-compose logs -f --tail=100

clear-cache:
	@$(web_docker_sh) drush cr

.PHONY: down build shell up dbshell clear-cache
