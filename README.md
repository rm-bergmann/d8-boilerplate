# Drupal 8.8.4 Composer

### Boilerplate Drupal Composer Project in Docker
This is a custom Drupal project intended as a Headless CMS set up to deliver content to multiple front end sites 
using Gatsby or any other JS framework. This project is inspired by Amazee Labs sposored Drupal modules such as [graphql](2), [webpack](3) and [components](4), [read this post](1) and [this post](5) for more details.

Different projects have different requirements, so I have worked on designing a system that can do the following:
* Drupal for adding and categorising content
* Custom Drupal Theme for personalisation
* Use Drupal views for displaying & finding content and information about the content for the users.
* Use Drupal theming / Twig for rendering web or landing pages that don't require much Javascript and for data provided by Drupal in Preprocess functions
* Use GraphQL to query data for Twig & React Components
* Use gatsby or other JS frameworks for fully decoupled sites using data from GraphQL
* Optionally mount React Apps on Drupal nodes for SPA functionality within Drupal (Progressive Decoupling)  


### Essential Tools included (port number):
* Drupal 8 (8090)
* Gulp + Browsersync (Drupal Themeing) (8091) & (8092)
* Gatsby / React (set port number `gatsy develop -p`)
* Cypress
* Playroom (8093)
* Storybook (8094)
* Webpack


##### To start a new D8 project follow these steps:

* Clone this repo, and remove the git directory.
* Rename the d8-boilerplate directory to your desired app-name
* Replace all instances of `app-name` to your new app-name in these files:
  - Makefile
  - Dockerfile
  - docker-compose.yml
  - docker-compose-prd.yml
* Add environment variables for your prodcution server in the docker-compose-prd file.

### Drupal

* To start the project run the `$ make` command (assuming you have `make` installed):
* Add a files directory inside `web/sites/default`.
* Go to `http://localhost:8090` and Install Drupal. You may need to make `web/sites/default/files` writeable.
* Once Drupal installs for some reason it throws an exception. To fix it follow these steps:
  - `make dbshell`
  - `truncate table cache_container`
  - Reload browser. If it still doesn't work try truncating all cache tables.
* Enable modules, set config, image styles etc, add content types and taxonomy terms then add content.
* For theming use Gulp and Browsersync
* `$ gulp serve` will initialise browsersync on port 8091.


### Gatsby
* To start the gatsby app you need to have the gatsby-cli installed globally.
* Gatsby is located in /front-end/test-site


### Playroom
* Playroom is a great tool to experiment laying out React components on differnet screensizes


### Storybook
* Storybook can display and test both React and Twig components

### Cypress
* Use Cypress for end to end testing the user journey from when they add content to saving the node and navigating to the URL that content is expected to be displayed.


## Notes
* I've included some essential modules which I use to start my projects, your project may not need all of them.
* If you do not have `make` installed run this command: `sudo apt-get make`
* If you are developing on windows, this will only work if you are using `WSL` or `WSL2`.
* For best performance either `WSL2` or any native Linux OS is recommended, so you can run Docker natively in Linux. 
* For localhost Drupal will load on port 8090. You can change this in the docker-compose file.
* In production it's set to port 80.

## ToDo's:
* Fix drupal console command not found error

[1]: https://www.amazeelabs.com/en/journal/using-twig-storybook-and-drupal
[2]: https://www.drupal.org/project/graphql
[3]: https://www.drupal.org/project/webpack
[4]: https://www.drupal.org/project/components
[5]: https://www.amazeelabs.com/en/journal/dont-push-it-using-graphql-twig