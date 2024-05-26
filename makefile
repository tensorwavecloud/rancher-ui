TEST_RANCHER_INSTANCE=rancher.18.236.138.233.sslip.io

build:
	docker buildx build -t rancher-nginx .

run: build
	docker run --name=rancher_nginx -e RANCHER_API=$(API) -d -p 8080:80 rancher-nginx

local-test: stop
	docker run --name=rancher_nginx -e RANCHER_API=$(TEST_RANCHER_INSTANCE) -d -p 8080:80 rancher-nginx
	sleep 2
	docker ps

show-nginx-config:
	docker exec -it rancher_nginx nginx -T

stop:
	docker stop rancher_nginx
	docker rm rancher_nginx
