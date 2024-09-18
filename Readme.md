# PHP-SERVICE-TEMPLATE

A template repository to setup a PHP webserver.

base docker setup - [Source](https://betterstack.com/community/guides/scaling-php/php-docker-images/#prerequisites)

## CONTENTS

- php-fpm <> nginx integration.

## COMMANDS

- attach to running container with bash (it was installed as of writing this!)

```
 docker exec -it *container-id* bash
 or
 docker-compose exec php-service bash
```

- activate everything in docker compose in detached mode ( -d flag ), and build it all ( --build flag, drop if no rebuild is needed )

```
 docker-compose up -d --build
```

## Steps needed after creating a fresh repository from this template

-. `docker-compose run --rm php-service bash` to build run and attach to a temporary (different) container

1.  `docker-compose exec php-service bash` to attach to the php-service container with a bash terminal
2.  `composer install` - this should happen through the Dockerfile idk why it doesnt. [todo]
3.  copy the `.env.example` to a `.env` in the project directory, then run `php artisan key:generate` (you can change the files before or after executing step 1. )

- Adjust paths in docker-compose.yaml and Dockerfile accordingly, this is the time to change example-project/example-app to your desired project names. </br>
  list of appearances: - [todo]

the idea is to init a new project with the appropriate name from within the containers filesystem to avoid installing dependencies, and then docker-compose up will mount the source code from the projects folder
