nginxContainer = nginxCompose
wordpressContainer = wordpressCompose
mariadbContainer = mariadbCompose

############################################################################

all: stop build run

stop:
	@if [ -n "$$(sudo docker ps | grep $(nginxContainer))" ]; then \
		sudo docker stop $(nginxContainer); \
	fi
	@if [ -n "$$(sudo docker ps | grep $(wordpressContainer))" ]; then \
		sudo docker stop $(wordpressContainer); \
	fi
	@if [ -n "$$(sudo docker ps | grep $(mariadbContainer))" ]; then \
		sudo docker stop $(mariadbContainer); \
	fi
	@echo "\033[0;32m[✔️] All containers have been stopped\033[0m"

build:
	@sudo docker-compose -f ./srcs/docker-compose.yml build
	@echo "\033[0;32m[✔️] docker-compose built successfully\033[0m"

run:
	@sudo docker-compose -f ./srcs/docker-compose.yml up

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
	@if [ -n "$$(sudo docker ps | grep $(nginxContainer))" ]; then \
		sudo docker kill $(nginxContainer); \
	fi
	@if [ -n "$$(sudo docker ps | grep $(wordpressContainer))" ]; then \
		sudo docker kill $(wordpressContainer); \
	fi
	@if [ -n "$$(sudo docker ps | grep $(mariadbContainer))" ]; then \
		sudo docker kill $(mariadbContainer); \
	fi
	@echo "\033[0;32m[✔️] All containers have been killed\033[0m"
	
clean:
	@if [ -n "$$(sudo docker ps -a | grep $(nginxContainer))" ]; then \
		sudo docker rm $(nginxContainer); \
	fi
	@if [ -n "$$(sudo docker ps -a | grep $(wordpressContainer))" ]; then \
		sudo docker rm $(wordpressContainer); \
	fi
	@if [ -n "$$(sudo docker ps -a | grep $(mariadbContainer))" ]; then \
		sudo docker rm $(mariadbContainer); \
	fi
	@echo "\033[0;32m[✔️] All containers have been deleted\033[0m"

clean-img:
	@if [ -n "$$(sudo docker images | grep srcs_nginx)" ]; then \
		sudo docker image rm srcs_nginx; \
	fi
	@if [ -n "$$(sudo docker images | grep srcs_wordpress)" ]; then \
		sudo docker image rm srcs_wordpress; \
	fi
	@if [ -n "$$(sudo docker images | grep srcs_mariadb)" ]; then \
		sudo docker image rm srcs_mariadb; \
	fi
	@echo "\033[0;32m[✔️] All images have been deleted\033[0m"

clean-network:
	@sudo docker network prune --force
	@echo "\033[0;32m[✔️] All networks have been deleted\033[0m"

fclean: stop clean clean-img
	@echo "\033[0;32m[✔️] It has all been reduced to dust\033[0m"

rm-volumes:
	@echo "\033[1;31m[!] Are you sure you want to delete all volumes? (y/n)\033[0m"
	@read -p "" confirm; \
	if [ "$$(echo $$confirm | tr '[:upper:]' '[:lower:]')" = "y" ] || [ "$$(echo $$confirm | tr '[:upper:]' '[:lower:]')" = "yes" ]; then \
		sudo rm -rf /home/tchevrie/wordpress /home/tchevrie/db; \
		echo "\033[0;32m[✔️] All volumes have been deleted\033[0m"; \
	else \
		echo "\033[0;33m[ℹ️] Operation canceled\033[0m"; \
	fi
purge: fclean clean-network rm-volumes

re: fclean all

purge-re: purge all

############################################################################

ps:
	@sudo docker ps
ls: ps

git:
	@if [ -z "$$(git status --porcelain)" ]; then \
		echo "\033[0;31m[!] Nothing to commit\033[0m"; \
		false; \
	fi
	@git add --all
	@git commit -m "$$(date +%d/%m-%H:%M)"
	@git push
	@echo "\033[0;32m[✔️] Git respository successfuly updated\033[0m"

.PHONY: all stop build run nginx wordpress mariadb kill clean clean-img clean-network fclean purge re purge-re ps ls git
