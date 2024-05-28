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
