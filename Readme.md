# PHP-SERVICE-TEMPLATE

A template repository to setup a PHP webserver.

base docker setup - [Source](https://betterstack.com/community/guides/scaling-php/php-docker-images/#prerequisites)

## CONTENTS
- php-fpm <--> nginx integration.

## COMMANDS

- attach to running container with bash (it was installed as of writing this!)
``` 
 docker exec -it *container-id* bash
```

- activate everything in docker compose in detached mode ( -d flag ), and build it all ( --build flag, drop if no rebuild is needed )
```
 docker-compose up -d --build
```

## Steps needed after creating a fresh repository from this template
1. 
    ``` 
    add this volume to the php service
    - ./example-project:/var/www/example-project:delegated
    ```
    - replace example-app with the name you want
2. ``` docker-compose --rm run php-service bash ``` to build run and attach to a temporary container 
3. ``` cd var/www ``` then run ``` composer create-project laravel/laravel *example-app* ``` - replace example-app with the name you want
5. Adjust paths in docker-compose.yaml and Dockerfile accordingly.

the idea is to init a new project with the appropriate name from within the containers filesystem to avoid installing dependencies, and then docker-compose up will mount the source code from the projects folder 