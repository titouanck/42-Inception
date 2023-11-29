nginxContainer = nginxCompose
wordpressContainer = wordpressCompose
mariadbContainer = mariadbCompose

############################################################################

all: stop build run

stop:
	@if [ -n "$$(sudo docker ps -q)" ]; then \
		sudo docker stop $$(sudo docker ps -q); \
	fi
	@echo "\033[0;32m[✔️] All containers have been stopped\033[0m"

build:
	sudo docker-compose -f ./srcs/docker-compose.yml build

run:
	sudo docker-compose -f ./srcs/docker-compose.yml up

############################################################################

nginx:
	@if [ -n "$$(sudo docker ps | grep $(nginxContainer))" ]; then \
    	echo "\033[0;32m[✔️] Entering $(nginxContainer)\033[0m"; \
		sudo docker exec -it $(nginxContainer) sh; \
	else \
    	echo "\033[0;31m[!] nginx container is not running\033[0m"; \
	fi

wordpress:
	@if [ -n "$$(sudo docker ps | grep $(wordpressContainer))" ]; then \
    	echo "\033[0;32m[✔️] Entering $(wordpressContainer)\033[0m"; \
		sudo docker exec -it $(wordpressContainer) sh; \
	else \
    	echo "\033[0;31m[!] wordpress container is not running\033[0m"; \
	fi

mariadb:
	@if [ -n "$$(sudo docker ps | grep $(mariadbContainer))" ]; then \
    	echo "\033[0;32m[✔️] Entering $(mariadbContainer)\033[0m"; \
		sudo docker exec -it $(mariadbContainer) sh; \
	else \
    	echo "\033[0;31m[!] mariadb container is not running\033[0m"; \
	fi

############################################################################

kill:
	@if [ -n "$$(sudo docker ps -q)" ]; then \
		sudo docker kill $$(sudo docker ps -q); \
	fi
	@echo "\033[0;32m[✔️] All containers have been killed\033[0m"
	
clean: stop
	@if [ -n "$$(sudo docker ps -qa)" ]; then \
		sudo docker rm $$(sudo docker ps -qa); \
	fi
	@echo "\033[0;32m[✔️] All containers have been deleted\033[0m"

clean-img: stop
	@if [ -n "$$(sudo docker images -q)" ]; then \
		sudo docker image rm $$(sudo docker images -q); \
	fi
	@echo "\033[0;32m[✔️] All images have been deleted\033[0m"

clean-network:
	sudo docker network prune --force
	@echo "\033[0;32m[✔️] All networks have been deleted\033[0m"

fclean:
	sudo docker system prune --force
	@echo "\033[0;32m[✔️] It has all been reduced to dust\033[0m"
purge: fclean

re: fclean all

############################################################################

ps:
	sudo docker ps
ls: ps

git:
	git add --all
	git commit -m "$$(date +%d/%m-%H:%M)"
	git push

.PHONY: all stop build run nginx wordpress mariadb kill clean clean-img clean-network fclean pruge re ps ls git
