all: hosts rvolumes volumes build up

hosts:
	@sudo sed -i "s/localhost/ametta.42.fr/g" /etc/hosts

build:
	docker-compose -f ./srcs/docker-compose.yml build

up:
	@docker-compose -f ./srcs/docker-compose.yml up -d

status:
	docker ps

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

down:
	docker-compose -f ./srcs/docker-compose.yml down

rm: rvolumes down
	docker system prune -af

re: rm all
	
rvolumes:
	sudo rm -rf ${HOME}/data

volumes:
	mkdir -p ${HOME}/data/db-data
	mkdir -p ${HOME}/data/www-data