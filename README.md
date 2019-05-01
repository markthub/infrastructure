# Markthub Infrastructure

The scope of this repository is to set up a "one-click" deployment to spin-up the infrastructure necessary to run the data platform.

## How to start

In order to run the application, first you need to have the image which allows you to run all commands without dependencies.

Prerequisites

- [Docker](https://www.docker.com/)
- [AWS](https://aws.amazon.com/)
- [AWS cli](https://aws.amazon.com/cli/)

Follow the steps below:

1. Clone the repository
2. Adjust Terraform state to the appropiate bucket+key, see `terraform/backend.tf`
3. Start your docker environment: `$ make build` or `$ make pull` will get the container needed in order to run manage the infrastructure.
    * Remember that you need to have the private key to access the modules on GitHub
4. Run the Docker app but first configure the following environmental variables:

```
export CLUSTER_ID=xxx
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
export AWS_DEFAULT_REGION=xxx

make run
```

4. Create/update infra and deploy Kubernetes packages
`$ make install` will spin up the whole infrastructure or updates it accordingly as well as the Kubernetes packages.

5. Delete all
`$ make uninstall` will remove all.

NOTE: if you exited the Docker and executed again the run `$ make config` 

## Kubernetes dashboard

Start first the proxy
```
make proxy
```

Access to the URL `http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:https/proxy/#!/overview?namespace=default` using the last returned token.