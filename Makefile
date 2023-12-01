GIT_REPO=42-Inception

USER := $(shell whoami)
nginxContainer = nginxCompose
wordpressContainer = wordpressCompose
mariadbContainer = mariadbCompose

HOSTS_FILE = /etc/hosts
DNS_REDIRECTION = $(shell echo $$USER).42.fr
TARGET_LINE = 127.0.0.1 $(DNS_REDIRECTION)

DOCKERHUB_IMG=alpine

# IF THIS NO LONGER WORK JUST MANUALLY PUT THE VERSION YOU WANT, (EX:PENULTIMATE_STABLE=3.17)
PENULTIMATE_STABLE=$(shell curl -s "https://www.alpinelinux.org/releases/" | grep "\-stable" | sed -n 2p  | sed -n 's/.*\/\([0-9.]\+\)-stable.*/\1/p')

############################################################################

all: setup-dns setup-alpine stop build run

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

setup-dns:
	@if ! grep -qF "$(TARGET_LINE)" $(HOSTS_FILE); then \
		echo "\033[0;33m[ℹ️] Adding $(TARGET_LINE) to $(HOSTS_FILE)\033[0m"; \
        echo "Adding $(TARGET_LINE) to $(HOSTS_FILE)"; \
		sudo echo "$(TARGET_LINE) #FROM $(GIT_REPO)" > /tmp/inception_dns.txt && sudo cat /etc/hosts >> /tmp/inception_dns.txt && sudo mv /tmp/inception_dns.txt /etc/hosts ; \
    else \
        echo "$(TARGET_LINE) already exists in $(HOSTS_FILE)"; \
    fi

setup-alpine:
	@if [ ! -n "$$(sudo docker images | grep $(DOCKERHUB_IMG) | grep PENULTIMATE_STABLE)" ]; then \
		echo "\033[0;33m[ℹ️] Pulling $(DOCKERHUB_IMG):$(PENULTIMATE_STABLE) from Dockerhub\033[0m"; \
		sudo docker pull $(DOCKERHUB_IMG):$(PENULTIMATE_STABLE); \
		sudo docker tag $(DOCKERHUB_IMG):$(PENULTIMATE_STABLE) $(DOCKERHUB_IMG):PENULTIMATE_STABLE; \
	else \
        echo "$(DOCKERHUB_IMG):$(PENULTIMATE_STABLE) already exists on this machine, to check for updates run 'make update-alpine'"; \
	fi

update-alpine: clean-img setup-alpine

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
	@if [ -n "$$(sudo docker images | grep 42-inception | grep nginx)" ]; then \
		sudo docker image rm nginx:42-inception; \
	fi
	@if [ -n "$$(sudo docker images | grep 42-inception | grep wordpress)" ]; then \
		sudo docker image rm wordpress:42-inception; \
	fi
	@if [ -n "$$(sudo docker images | grep 42-inception | grep mariadb)" ]; then \
		sudo docker image rm mariadb:42-inception; \
	fi
	@if [ -n "$$(sudo docker images | grep PENULTIMATE_STABLE | grep alpine)" ]; then \
		sudo docker image rm -f alpine:PENULTIMATE_STABLE; \
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

clean-dns:
	@sudo sed -i '/#FROM $(GIT_REPO)/d' /etc/hosts
	@echo "\033[0;32m[✔️] Inception DNS redirections have been deleted\033[0m"

fclean: stop clean clean-img clean-network clean-dns
re: fclean all

purge: fclean clean-volumes
purge-re: purge all

############################################################################

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
	
.PHONY: all setup-dns setup-alpine update-alpine stop build run nginx wordpress mariadb kill clean clean-img clean-network clean-volumes clean-dns fclean re purge purge-re git dns-check
