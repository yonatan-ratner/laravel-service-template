# PHP-SERVICE-TEMPLATE

A template repository to setup a PHP webserver.

base docker setup - [Source](https://betterstack.com/community/guides/scaling-php/php-docker-images/#prerequisites)

## CONTENTS
- php-fpm to nginx integration.
## COMMANDS

- simulate container as local dev env with bash shell access
``` 
 docker compose run api bash
```

- setup localhost live-service
``` 
docker compose up api 
```

- setup for deployment
``` 
TODO 
```

* when changing dependencies
``` 
docker compose build 
```