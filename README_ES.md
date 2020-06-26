![Angular-docker image](https://miro.medium.com/max/2000/1*GeGazytoczNAQSsPb-gHSw.png)

# :whale: Desarrollo con Angular usando Docker

Este codigo de ejemplo incluye todos los pasos necesarios para desarrollar cualquier aplicacion de Angular usando :whale: Docker, ambos entornos, desarrollo y produccion estan configurados para que solamente tenga que hacer `docker-compose up` e inicie a trabajar.

## :triangular_flag_on_post: Como funciona?

El proyecto tiene 2 archivos, un archivo `Dockerfile` y un archivo `docker-compose.yaml` con las configuraciones para Docker en ambos entornos.

El archivo Dockerfile contiene los comandos e importaciones requeridas para configurar el entorno de desarrollo hasta la linea 25, despues de eso, los comandos son para el entorno de produccion tal como el import de la imagen de nginx, los archivos compilados para produccion y el hecho de copiar los archivos finales al folder principal de nginx.

Hay un archivo `.env-example` que contiene variables globales requeridas para el deployment, este archivo debe duplicarse y renombrarse a solamente `.env`.

## :wrench: El archivo docker-compose.yaml

El archivo `docker-compose.yaml` es el que nos ayuda a iniciar el contenedor y constriurlo si aun no esta hecho, configuramos dos servicios, `env` y `prod`, y las configuraciones para cada uno.

Para el entorno `dev`, el puerto utilizado es el `3000` y para el entorno `prod` el puerto utilizado es el `3001`.

### :construction_worker: Cambios en el archivo PACKAGE.JSON

Para que este proyecto funcione, debes agregar dos scripts en `package.json`, la nueva estructura de la seccion de `scripts` deberia verse similar a la siguiente:

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

## :rocket: Archivo de configuracion de NgInx.

Y por ultimo, pero no menos importante, necesitamos crear un nuevo archivo dentro de la carpeta _docker/nginx_ llamado `default.conf`, este archivo va a ser movido en el ultimo paso de la imagen de produccion y sobreescribira las configuraciones por defecto de la imagen de `nginx`.

## :building_construction: Construir el contenedor

Para iniciar ya sea el contenedor dev o prod solo tienes que hacer:

```bash
docker-compose up
```

Esto construira la imagen, descargara las imagenes requeridas como node y nginx, instalara los paquetes del proyecto y luego, podremos revisar el entorno `dev` en http://localhost:3000, con respecto al entorno de `prod`, se puede revisar en http://localhost:3001.

Si solo quieres levantar ya sea `dev` o `prod`, lo requerido para hacer es `docker-compose up dev` o `docker-compose up prod` segun sea conveniente, de esta manera solo tendremos el que nos interese.

## :white_check_mark: Configuración de test para integración continua

Para poder correr los test dentro de una integración continua es necesario utilizar la configuración de un explorador Headless (es decir sin interfaz de usuario).

La configuración para el uso de Chrome Headless ya esta incorporada en el proyecto, siguiendo las guias oficiales de Angular [Angular Testing](https://angular.io/guide/testing).

Chromium tambien está configurado dentro de la imagen de docker sin embargo es posible que se necesite configuracion adicional dependiendo de el entorno de ambiente o pipeline usado.

Para correr los test dentro del pipeline de intregación continua se recomiendan los siguientes comandos:

```bash
npm run test -- --no-watch --no-progress --browsers=ChromeHeadlessCI
npm run e2e -- --protractor-config=e2e/protractor-ci.conf.js
```

Para poder correr los test dentro de la imagen de docker creada, primero construye la imagen con `bash docker-compose build` y luego utiliza el siguiente comando de docker:

```bash
docker run -it --rm ng-docker-boilerplate_dev npm run test -- --no-watch --no-progress --browsers=ChromeHeadlessCI
```

### :see_no_evil: Pensamientos finales

Esta compilacion de codigo esta enteramente basada en informacion reunida de otros proyectos y con la gran contribucion de [Carlos Lopez](https://github.com/clopez-app) quien es el verdadero experto aqui, sin su ayuda, no habria podido empezar este repositorio.

Saludos!
