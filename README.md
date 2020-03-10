# Drupal 8.8.3 Composer

### Boilerplate Drupal Composer Project in Docker

##### To start a new D8 project follow these steps:

* Clone this repo, and remove the git directory.
* Rename the d8-boilerplate directory to your desired app-name
* Replace all instances of `app-name` to your new app-name in these files:
  - Makefile
  - Dockerfile
  - docker-compose.yml
  - docker-compose-prd.yml
* Add environment variables for your prodcution server in the docker-compose-prd file.

### To start the project run the following command (assuming you have `make` installed):

`$ make`

## Notes
* I've included some essential modules which I use to start my projects, your project may not need all of them.
* If you do not have `make` installed run this command: `sudo apt-get make`
* If you are developing on windows, this will only work if you are using `WSL` or `WSL2`.
* For best performance either `WSL2` or any native Linux OS is recommended, so you can run Docker natively in Linux. 
* For localhost Drupal will load on port 8090. You can change this in the docker-compose file.
* In production it's set to port 80.

## ToDo's:
* Run composer install in Dockerfile
* Install Storybook and Cypress
* Fix drupal console command not found error