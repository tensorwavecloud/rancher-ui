
build:
	docker buildx build -t rancher-nginx .

run: build
	docker run --name=rancher_nginx -e RANCHER_API=$(API) -d -p 8080:80 rancher-nginx

stop:
	docker stop rancher_nginx
	docker rm rancher_nginx
