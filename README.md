![Angular-docker image](https://raw.githubusercontent.com/gbumanzor/ng-docker-boilerplate/master/angular-docker.png)

#  :whale: Angular Development using Docker

This boilerplate includes all the necessary steps to develop any angular application using :whale: Docker, both the development and the production environments have been set up for you to just do `docker-compose up` and start working.

## :triangular_flag_on_post: How does it work?
The project has both a `Dockerfile` and a `docker-compose.yaml` file with the configurations for Docker.

The Dockerfile contains the commands and required imports to set up the development environment all the way until line 25, after that, the commands are for production environment, such as the imports for nginx image, the production build files and then copying them into `nginx` main folder to serve them.

There's an `.env-example` file that contains global variable examples required for deployment.

## :wrench: The docker-compose.yaml file
The `docker-compose.yaml` file is the one that helps up start the container and build it if not built already, we set two services, `dev` and `prod` and the configurations for each.

For the development environment, the port used is `3000` and for production environment the port being used is `3001`.

### :construction_worker: Changes in package.json

In order for this boilerplate to work, you must add two scripts in `package.json`, the new structure for the scripts section is something similar to this: 

```json
"scripts": {
    "ng": "ng",
    "start": "ng serve",
    "build": "ng build",
    "build-prod": "ng build --prod",
    "test": "ng test",
    "lint": "ng lint",
    "e2e": "ng e2e",
    "serve": "ng serve --host 0.0.0.0"
  },
```


## NgInx configuration file. 
And last but no least, you need to create a new file inside the docker/nginx folder called `default.conf` this file is going to be moved in the last step of the production build and override the default configurations for the nginx image.


