USER := $(shell whoami)
nginxContainer = nginxCompose
wordpressContainer = wordpressCompose
mariadbContainer = mariadbCompose

HOSTS_FILE = /etc/hosts
DNS_REDIRECTION = $(shell echo $$USER).42.fr
TARGET_LINE = 127.0.0.1 $(DNS_REDIRECTION)

############################################################################

all: stop dns build run

dependencies:
	@echo "To make this work, you may need to install:"
	@echo "- docker"
	@echo "- docker-compose"
	@echo "- dnsmasq"
	@echo "- The corresponding alpine-linux image from dockerhub needed by the containers (Required on certain distribs only)"

############################################################################

dns:
	@if ! grep -qF "$(TARGET_LINE)" $(HOSTS_FILE); then \
		echo "\033[0;33m[ℹ️] Adding $(TARGET_LINE) to $(HOSTS_FILE)\033[0m"; \
        echo "Adding $(TARGET_LINE) to $(HOSTS_FILE)"; \
        sudo sh -c "echo '$(TARGET_LINE)' >> $(HOSTS_FILE)"; \
    else \
        echo "$(TARGET_LINE) already exists in $(HOSTS_FILE)"; \
    fi

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
	@echo "\033[0;32m[✔️] Inception containers have been stopped\033[0m"

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
	@echo "\033[0;32m[✔️] Inception containers have been killed\033[0m"
	
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
	@echo "\033[0;32m[✔️] Inception containers have been deleted\033[0m"

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
	@echo "\033[0;32m[✔️] Inception images have been deleted\033[0m"

clean-network:
	@if [ -n "$$(sudo docker network ls --filter "name=inception" -q)" ]; then \
		sudo docker network rm $$(sudo docker network ls --filter "name=inception" -q); \
	fi
	@echo "\033[0;32m[✔️] Inception network has been deleted\033[0m"

clean-volumes:
	@echo "\033[1;31m[!] Are you sure you want to delete wordpress and db volumes? (y/n)\033[0m"
	@read -p "" confirm; \
	if [ "$$(echo $$confirm | tr '[:upper:]' '[:lower:]')" = "y" ] || [ "$$(echo $$confirm | tr '[:upper:]' '[:lower:]')" = "yes" ]; then \
		sudo rm -rf /home/$(USER)/data/wordpress /home/$(USER)/data/db ; \
		if [ -d "/home/$(USER)/data" ] && [ -z "$$(ls -A "/home/$(USER)/data")" ]; then \
        	sudo rm -rf "/home/$(USER)/data"; \
    	fi; \
		echo "\033[0;32m[✔️] Inception volumes have been deleted\033[0m"; \
	else \
		echo "\033[0;33m[ℹ️] Operation canceled\033[0m"; \
	fi

fclean: stop clean clean-img clean-network 
re: fclean all

purge: fclean clean-volumes
purge-re: purge all

############################################################################

ps:
	@sudo docker ps
ls: ps

git:
	@if [ -z "$$(git status --porcelain)" ]; then \
		echo "\033[0;33m[ℹ️] Nothing to commit\033[0m"; \
		false; \
	fi
	@git add --all
	@git commit -m "$$(date +%d/%m-%H:%M)"
	@git push
	@echo "\033[0;32m[✔️] Git respository successfuly updated\033[0m"

dns-check:
	@if [ -n "$$(sudo docker ps | grep $(nginxContainer))" ] && [ -n "$$(sudo docker ps | grep $(wordpressContainer))" ] && [ -n "$$(sudo docker ps | grep $(mariadbContainer))" ]; then \
		curl -k -X GET https://$(DNS_REDIRECTION) || { echo "\033[0;31m[❌] DNS redirection is not working at: https://$(DNS_REDIRECTION) \033[0m"; exit 1; } ; \
		echo "\033[0;32m[✔️] DNS redirection is working at: https://$(DNS_REDIRECTION) \033[0m" ; \
	else \
		echo "\033[0;33m[ℹ️] Inception containers are not running, therefore dns-check cannot be done.\033[0m"; \
	fi
	
.PHONY: all dependencies dns stop build run nginx wordpress mariadb kill clean clean-img clean-network clean-volumes fclean re purge purge-re ps ls git dns-check
