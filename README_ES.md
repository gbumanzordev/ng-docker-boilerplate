![Angular-docker image](https://miro.medium.com/max/2000/1*GeGazytoczNAQSsPb-gHSw.png)

#  :whale: Desarrollo con Angular usando Docker

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
Y por ultimo, pero no menos importante, necesitamos crear un nuevo archivo dentro de la carpeta *docker/nginx* llamado `default.conf`, este archivo va a ser movido en el ultimo paso de la imagen de produccion y sobreescribira las configuraciones por defecto de la imagen de `nginx`.

## :building_construction: Construir el contenedor
Para iniciar ya sea el contenedor dev o prod solo tienes que hacer: 
```bash
docker-compose up
```

Esto construira la imagen, descargara las imagenes requeridas como node y nginx, instalara los paquetes del proyecto y luego, podremos revisar el entorno `dev` en http://localhost:3000, con respecto al entorno de `prod`, se puede revisar en http://localhost:3001.

Si solo quieres levantar ya sea `dev` o `prod`, lo requerido para hacer es `docker-compose up dev` o `docker-compose up prod` segun sea conveniente, de esta manera solo tendremos el que nos interese.


### :see_no_evil: Pensamientos finales
Esta compilacion de codigo esta enteramente basada en informacion reunida de otros proyectos y con la gran contribucion de [Carlos Lopez](https://github.com/clopez-app) quien es el verdadero experto aqui, sin su ayuda, no habria podido empezar este repositorio.

Saludos!