## xap-docker for XAP 12.1

This repository contains:

1. Dockerfile of [GigaSpaces XAP](http://www.gigaspaces.com/imc)
2. [Azure templates](azure-templates/README.md) to run XAP on Azure
3. [Kubernetes deployment configuration files](kubernetes-templates/README.md) to deploy XAP with Kubernetes

### Installation

1. Install [Docker](https://www.docker.com/).

2. Clone [xap-docker](https://github.com/xap/xap-docker.git)

3. cd xap-docker 

4. Build an image from Dockerfile: `docker build -t gigaspaces/xap:12.1.0 .`

### Run XAP 12.1 Data Grid across three con

#### XAP Manager node

Run a 3-quorum XAP 12.1 cluster

	docker run --name xap -d -p 8090:8090 -P gigaspaces/xap:12.0.1 --manager
    docker run --name xap -d -P gigaspaces/xap:12.0.1 --manager
	docker run --name xap -d -P gigaspaces/xap:12.0.1 --manager

#### REST Orchestration 

Check list of data grid nodes
	curl -X GET --header 'Accept: application/json' 'http://localhost:8090/v1/hosts'


