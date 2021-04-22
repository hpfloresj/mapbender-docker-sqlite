![Mapbender](./dockerfiles/mapbender_shared/logo.png)

# Mapbender docker (SQLite)

Mapbender docker setup example configured to use a sqlite database.


Mapbender is a web based geoportal framework.

[Official site](https://mapbender.org/?q=en) | [Live demo](https://demo.mapbender.org/) | [News on Twitter](https://twitter.com/mapbender)

For detailed usage information, including installation and integration topics, please see [official documentation](https://doc.mapbender.org/en/) ([also available in German](https://doc.mapbender.org/de/)).

## Requirements

- docker
- docker-compose

### Docker installation

#### MacOS / Windows

Visit https://docs.docker.com/desktop/ (docker) and https://docs.docker.com/compose/install/ (docker-compose) and follow the installation instructions for your operating system. 

#### Linux

It is important to follow the installation instructions linked below since software repositories provided by linux distributions usually deliver outdated docker and docker-compose versions.

docker: https://docs.docker.com/engine/install 
docker-compose: https://docs.docker.com/compose/install/

## Getting started

### Download

Download and unpack the repository and ```cd``` into the repositories root folder using your terminal (Linux/Mac) or Powershell (Windows).

### Start the setup

#### Linux 

Run ```./mapbender_dev_up``` to create and start a Mapbender development setup.

#### Windows 

Run ```docker-compose -f docker-compose.yml -f docker-compose_dev.yml up --build``` to create and start a Mapbender development setup.

### Access Mapbender using your browser

Open ```localhost:4000``` in your browser to access the webinterface (user & password: mb_root).

Mapbender code is accessible in ```volumes/mapbender/application/```.

