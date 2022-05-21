# DOCKER GUI APP

A simple example about how to run a GUI application inside a docker container.

- [Docker image](#docker-image)
  * [GUI](#gui)
    + [Disabling the X server security](#disabling-the-x-server-security)
    + [Using an X Cookie](#using-an-x-cookie)
  * [Environment variables](#environment-variables)
  * [Entrypoint](#entrypoint)
  * [Application](#application)
  * [Debugging](#debugging)
- [Docker compose](#docker-compose)
  * [Environment variables](#environment-variables-1)
  * [Volume mounts](#volume-mounts)
  * [Running the compose file](#running-the-compose-file)
  * [Debugging](#debugging-1)
- [Running the solution](#running-the-solution)

## Docker image

### GUI

To enable the GUI you need to mount the host X socket and enable the X client
connection.

To mount the host's X server socket, use the volume mount:

`/tmp/.X11-unix:/tmp/.X11-unix`


To enable the X client there are two options:
* Disable all the security so anyone can get connected (not recommended but easier)
* Use your host X cookie for the connection (recommended).

#### Disabling the X server security

To disable the security and allow any X client, run:

```bash
xhost +
```

To enable back the authentication, execute:

```bash
xhost -
```

#### Using an X Cookie

To get a valid X cookie run the following command and copy one of the printed
32 byte-length numerical value. Then define the `X_COOKIE` environment variable:

``` bash
xauth list
export X_COOKIE=<value>
```

### Environment variables

| Environment variable | Description |
| -------------------- | ----------- |
| DEBUG | Enable debug verbosity |
| X_COOKIE | X Server cookie to authenticate the connection. You can get it from the `xauth list` command. |
| DISPLAY | Host display number, this is usually already defined. |

### Entrypoint

After configuring the environment, the entrypoint will execute the
application as:

```bash
/app/application.py $@
```

### Application

For this example, the application is a simple Hello World using Tkinter.

### Debugging

To execute an interactive session inside a container using bash, run:

```bash
# note the container name:
docker ps | grep dockergui_gui-app
docker exec -it <container_name> bash
```

## Docker compose

You will find a compose file with the required configuration to set a
`gui-app` service that builds and uses the hello world gui app image.

### Environment variables

The compose file expects the same environment variables as the Docker image.
Define them in you bash session using `export <VARIABLE>=<VALUE>` and they
will automatically pulled by the compose file.

### Volume mounts

`/tmp/.X11-unix:/tmp/.X11-unix`
The host `.X11-unix` socket used to connect to the X server will be mounted
in the same location at the docker image.

### Running the compose file

Execute the command:

```bash
docker-compose -f docker-compose.yaml build gui-app
docker-compose -f docker-compose.yaml run gui-app
```

### Debugging

To execute a bash command instead of the entrypoint:

```bash
docker-compose run --entrypoint bash gui-app -c "<command>"
```

## Running the solution

You will find a `run.sh` script that facilitates the environment setup. The
script will obtain and set the `X-COOKIE` environment variable and check the
`files` folder.

To run the solution, execute the following command:

```bash
./run.sh
```
