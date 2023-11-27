all: stop build run

build:
	sudo docker build ./srcs/requirements/nginx -t nginx_tls

run:
	sudo docker run -v $$(pwd)/html:/html -d -p 8000:80 nginx_tls

exec:
	if [ -n "$$(sudo docker ps -q)" ]; then \
		sudo docker exec -it $$(sudo docker ps -q) sh; \
	fi

tty: all exec

stop:
	if [ -n "$$(sudo docker ps -q)" ]; then \
		sudo docker stop $$(sudo docker ps -q); \
	fi

kill:
	if [ -n "$$(sudo docker ps -q)" ]; then \
		sudo docker kill $$(sudo docker ps -q); \
	fi
	
clean: stop
	if [ -n "$$(sudo docker ps -qa)" ]; then \
		sudo docker rm $$(sudo docker ps -qa); \
	fi

fclean: clean
	if [ -n "$$(sudo docker images -q)" ]; then \
		sudo docker image rm $$(sudo docker images -q); \
	fi


re: fclean all

git:
	git add --all
	git commit -m "$$(date +%d/%m-%H:%M)"
	git push

.PHONY: all build run exec tty stop kill clean fclean re git
