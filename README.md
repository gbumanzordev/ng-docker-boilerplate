![Angular-docker image](https://miro.medium.com/max/2000/1*GeGazytoczNAQSsPb-gHSw.png)

This document is also available in Spanish [here](https://github.com/gbumanzor/ng-docker-boilerplate/blob/master/README_ES.md)

# :whale: Angular Development using Docker

This boilerplate includes all the necessary steps to develop any angular application using :whale: Docker, both the development and the production environments have been set up for you to just do `docker-compose up` and start working.

## :triangular_flag_on_post: How does it work?

The project has both a `Dockerfile` and a `docker-compose.yaml` file with the configurations for Docker.

The Dockerfile contains the commands and required imports to set up the development environment all the way until line 25, after that, the commands are for production environment, such as the imports for nginx image, the production build files and then copying them into `nginx` main folder to serve them.

There's an `.env-example` file that contains global variable examples required for deployment. This file should be duplicated and renamed to `.env` only.

## :wrench: The docker-compose.yaml file

The `docker-compose.yaml` file is the one that helps up start the container and build it if not built already, we set two services, `dev` and `prod` and the configurations for each.

For the development environment, the port used is `3000` and for production environment the port being used is `3001`.

## :construction_worker: Changes in package.json

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

## :rocket: NgInx configuration file.

And last but no least, you need to create a new file inside the _docker/nginx_ folder called `default.conf` this file is going to be moved in the last step of the production build and override the default configurations for the nginx image.

## :building_construction: Build the container

In order to start either your dev or prod container you will only need to do:

```bash
docker-compose up
```

It will build the image, download the required node and nginx images and then you will be able to check the dev environment in http://localhost:3000 and your production environment in http://localhost:3001

If you only want to serve either dev or prod images you will only need to do `docker-compose up dev` or `docker-compose up prod` and only one of them will be served.

## :white_check_mark: CI Testing

In order to make use of CI Testing a Headless browser is required.

Configuration for Headless Chrome is already setup within the proyect following the official guidelines from Angular [Angular Testing](https://angular.io/guide/testing).

Chormium is also included in the docker image configuration, however additional configuration may be required for your specific environment or pipeline.

To run the test within the CI pipeline the following commands are recommended:

```bash
npm run test -- --no-watch --no-progress --browsers=ChromeHeadlessCI
npm run e2e -- --protractor-config=e2e/protractor-ci.conf.js
```

In order to run the test with your local image make sure to run `bash docker-compose build` and then use the following command:

```bash
docker run -it --rm ng-docker-boilerplate_dev npm run test -- --no-watch --no-progress --browsers=ChromeHeadlessCI
```

## :see_no_evil: Final thougts

This boilerplate is entirely based on information gathered from other projects and with the great contribution of [Carlos Lopez](https://github.com/DarkDreizer) who's the expert on this, without his help I wouldn't even have been able to even start this boilerplate.

Kind regards,
