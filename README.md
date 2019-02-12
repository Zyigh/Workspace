# Workspace

Version : POC

## Description

Workspace is a dockerized workspace generator.  
The main purpose is to easily create a new project with everything you need automaticcaly build as microservices. Of course, as every project is special, you might have some special requirements. This is why all the Dockerfiles are easily editable, just as the docker-compose.yml.

## Features

- [x] Webapp : Create a webapp workspace
    - [x] PHP 
    - [x] MySQL
    - [x] Apache
    - [] NGINX
    - [] PostgreSQL
    - [] NodeJS

## Install

As this still is a proof of concept, this software **SHALL NOT BE USED** by anyone. Yet if you like to live dangerously, you can execute :

```bash
git clone https://github.com/Zyigh/Workspace.git    // Clone this repo
cd ./Workspace
./install
```

This will ask for your password to own the whole directory and so be able to execute programs in it.

## Usage

As this still is a proof of concept, this software **SHALL NOT BE USED** by anyone. Yet if you like to live dangerously, you can run :

```bash
workspace php [project-name]
```

That command will create a directory [project-name] with a dockerized LAMP stack. [Project-name] can also be the path where you want to build your project.  
Note that :
```bash
workspace
```

will create the same environment in the current folder

## Errors
 
Errors are not handled. This is part of the reasons why this software **SHALL NOT BE USED** by anyone

## Versions

This software is tested on Mac OS X 10.14, with docker version 18.09.1 and docker-compose version 1.23.2.
More tests on anterior versions will have to be made in later versions, hoping that it will compile on Linux asap.

## Contribute

Wait for a MVP before doing so :)

## License

[License can be found here](./License)
