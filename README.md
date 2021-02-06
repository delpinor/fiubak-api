# Web Template

This is a simple web project based on Padrino.

### Run local with Docker

For docker development purpose, you may install
[docker](https://docs.docker.com/get-docker/)

1\) You first need to build the image running:

`docker build -f Dockerfile -t <image_name:version> .`

For image name, you can avoid version so it will be build as "latest".
For example, web-template or web-template:1.0.0

`docker build -f Dockerfile -t web-template .`

2\) Once you have the image, you can start the server with:

`docker run -it -p <port>:<port> <image_name:version>`

Again, for example:

`docker run -it -p 3000:3000 web-template`

Then, open the browser and go to http://0.0.0.0:3000

### Run local with Docker Compose

First, get [docker-compose](https://docs.docker.com/compose/install/).

Then, you can run script `start_dev_containers.sh`. After this, you will be inside the container.

Start the app with `bundle exec padrino start -h 0.0.0.0` and check health in another terminal at `http://localhost:3000/`


### Run local with Vagrant

1\) Install [Vagrant](https://www.vagrantup.com/downloads.html)

2\) Run `vagrant up`. This will create a virtual machine in virtual box as specified on `Vagrantfile`

3\) When all the installation finish, you get inside that VM with `vagrant ssh` and run:

```
cd /vagrant
bundle
```

4.1\) You have your environment ready. You can start the app running `bundle exec padrino start -h 0.0.0.0`

4.2\) Set `DATABASE_URL=postgres://webtemplate:webtemplate@localhost/webtemplate_development` before running

5\) When you are done, don't forget to leave ssh (just exit in vagrant shell) and stop the VM with `vagrant halt`

Every time you want to start the server, you may repeat step 3 and 4.


### Deploy with Dockerfile + Heroku

1\) Set `HEROKU_TOKEN` environment var with your heroku token.

2\) Run `./scripts/build-image.sh` to create the binary and then `./scripts/deploy.sh` to update heroku runtime.


# Acceptance Test

During development, when a developer works on his cucumber create an in-process instance of the application, so it is enough to run cucumber, nothing else is needed.
