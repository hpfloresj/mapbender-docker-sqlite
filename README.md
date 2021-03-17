![Mapbender](./dockerfiles/mapbender_shared/logo.png)

# Mapbender docker (SQLite)

Mapbender docker setup example configured to use a sqlite database.


Mapbender is a web based geoportal framework.

[Official site](https://mapbender.org/?q=en) | [Live demo](https://demo.mapbender.org/) | [News on Twitter](https://twitter.com/mapbender)

For detailed usage information, including installation and integration topics, please see [official documentation](https://doc.mapbender.org/en/) ([also available in German](https://doc.mapbender.org/de/)).

## Requirements

- docker
- docker-compose

## Getting started

Run ```./mapbender_dev_up``` to create and start a Mapbender development setup.

Open ```localhost:4000``` in your browser to access the webinterface (user & password: mb_root).

Mapbender code is accessible in ```volumes/mapbender/application/```.
