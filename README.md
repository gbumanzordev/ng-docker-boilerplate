#  :whale: Angular Development using Docker

[alt text][angular-docker]


This boilerplate includes all the necessary steps to develop any angular application using :whale: Docker, both the development and the production environments have been set up for you to just do `docker-compose up` and start working.

## :triangular_flag_on_post: How does it work?
The project has both a `Dockerfile` and a `docker-compose.yaml` file with the configurations for Docker.

The Dockerfile contains the commands and required imports to set up the development environment all the way until line 25, after that, the commands are for production environment, such as the imports for nginx image, the production build files and then copying them into `nginx` main folder to serve them.

There's an `.env-example` file that contains global variable examples required for deployment.

## The docker-compose.yaml file
The `docker-compose.yaml` file is the one that helps up start the container and build it if not built already, we set two services, `dev` and `prod` and the configurations for each.

For the development environment, the port used is `3000` and for production environment the port being used is `3001`.

