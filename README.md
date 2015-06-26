docker-friendica
================

[![Docker Hub](https://img.shields.io/badge/docker-mkaag%2Ffriendica-008bb8.svg)](https://registry.hub.docker.com/u/mkaag/friendica/)

This repository contains the **Dockerfile** to run [Friendica](http://www.friendica.com/) for [Docker](https://www.docker.com/).

### Base Docker Image

* [phusion/baseimage](https://github.com/phusion/baseimage-docker), the *minimal Ubuntu base image modified for Docker-friendliness*...
* ...[including image's enhancement](https://github.com/racker/docker-ubuntu-with-updates) from [Paul Querna](https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/)

### Installation

```bash
docker build -t mkaag/friendica github.com/mkaag/docker-friendica
```

### Usage

#### Basic usage

```bash
docker run -d -p 80:80 mkaag/friendica
```
