# README

[![](https://badge.imagelayers.io/softwarecraftsmen/atlassian-confluence:latest.svg)](https://imagelayers.io/?images=softwarecraftsmen/atlassian-confluence:latest)

## Prepare a docker host

```sh
docker-machine create --driver virtualbox atlassian <1>
docker-machine start atlassian <2>
eval `docker-machine env atlassian` <3>
```

1. Create a docker machine (once only)
2. Start the docker machine
3. Setup the docker client to use the docker-machine

## Run a Confluence instance

```sh
docker pull softwarecraftsmen/atlassian-confluence
docker run -d --name confluence -p 8090:8090 atlassian-confluence
```

Startup after creating a container takes some time as the installation and configuration process is continuing. So be patient until the start page for license registration can be opened.

To open the Confluence start page on Mac OSX run from the shell:
```
open http://`docker-machine ip atlassian`:8090
```

Once a license has been installed into the server it is bound to the server's ID. The license and server ID can be retrieved through http://my.atlassian.com. So when creating a new container and a valid license still exist the server ID can be set with `confluence.cfg.xml` in the confluence home dir (`/var/atlassian/application-data/confluence`).
