## Installation

You will need to install the following packages:
```sh
yarn add --dev @vue/cli-plugin-babel                                                             
yarn add --dev @babel/plugin-proposal-class-properties
```

## Development

I'm not sure which version of Node is actually required but... to get the development service up and running you will need to set the following Node option:
```sh
set NODE_OPTIONS=--openssl-legacy-provider
```

The following line should bring up a development environment.  ***NOTE***: The `API` option MUST point to a running Rancher API instance:
```sh
NODE_OPTIONS=--openssl-legacy-provider API=https://rancher.18.236.138.233.sslip.io yarn dev
```

## Deployment to Docker (local)

Run docker compose on the docker-compose.yml file found in the base of this repository:
```sh
docker-compose up -d -f ./docker-compose.yml
```

## Deployment to Kubernetes

1. Add the [Rancher Helm Chart] repository:
```sh
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
```

2. Install the [Rancher Helm Chart] you should use something similar to the following command:
```sh
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set ingress.tls.source=letsEncrypt \
  --set hostname=<YOUR HOSTNAME HERE> \
  --set bootstrapPassword=<YOUR PASSWORD HERE> \
  --set rancherImage=scull7/tensorwave-rancher \
  --set rancherImageTag=latest
```
NOTE: The 2 most important options here are `rancherImage` and `rancherImageTag`.
These options are used to specify the image that will be used to run the Rancher server.
The `rancherImage` option should be set to the image that you want to use (i.e. the Tensorwave Version) and
the `rancherImageTag` option should be set to the tag of the image that you want to use (i.e. `latest`).

[Rancher Helm Chart]: https://artifacthub.io/packages/helm/rancher-stable/rancher
