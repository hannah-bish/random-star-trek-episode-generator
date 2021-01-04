This template repo provides a basic framework to develop and publish a Docker image for a single service. An application comprised of several services may have several repos based on this template repo. This template repo is not intended to deploy an entire application to qa, production, etc. Deployment and operations workflows need to be addressed in a separate repo. This what the [DevOps GitHub template](https://github.com/dfmedia/devops-template) addresses.

This template contains the following integrations:
* CircleCI for CI/CD. CircleCI is configured to be triggered by PR's, merges, and Git tags. It will always run tests, but it will only publish a docker image on either merges or Git hub tags to the `master` branch.
* Ansible for configuration management whose use is optional. Among other things, it enables encrypted secrets to be stored within the Git repo
   
This template is generic so virtually any language or framework can be added to it. If your team needs to create many services with a particular language or framework, you can create another GitHub template from this one and add language or framework-specific starter files to it. 
   
NOTES: 
* GitHub Actions is a nice alternative to CircleCI, however some MNG teams work with forked repos. These teams need CI/CD to run on a PR from a forked repo based on the CI/CD configurations ***in the PR***. GitHub Actions does not support this as of November 2020. Please see [pull_request](https://docs.github.com/en/free-pro-team@latest/actions/reference/events-that-trigger-workflows#pull_request) and [pull_request_target](https://docs.github.com/en/free-pro-team@latest/actions/reference/events-that-trigger-workflows#pull_request_target). If your team does not work with forked repos, feel free to replace CircleCI with GitHub Actions.
# Preparing this repo

## Don't need configuration management?
Ansible safely manages configuration values and secrets (e.g. passwords, API tokens, connection strings) that need to be shared within a development team.  It can apply these configurations values to Jinja templates to generate the configuration files needed by your application and its associated tools. The typical Ansible use-case for this GitHub repo template is to generate (or "cook") Docker Compose files and related files with the decrypted credentials and other configuration values. These resultant files can then be run with any Docker/Docker Compose tools.

If this repo will not require secrets and Ansible is not practical for it, remove Ansible by simply removing the
following files/directories:
```
ansible/
ansible.cfg
```
You can then skip any Ansible-related instructions and manage your configurations and Docker Compose files as you'd like.

## Required Tweaks
### Local Docker image builds
1. Ensure the Docker image can be built locally by completing the tasks marked with `TODO` in `./build-docker-image.sh`.
1. Build the Docker image:
   ```
   ./build-docker-image.sh
   ```
1. Verify Docker image was built with the `latest` tag, by running the following:
   ```
   docker images
   ```

### Ansible (if using)
Encrypting configuration:
1. Generate an Ansible Vault password with a tool like LastPass.
1. Save this password in LastPass so it can be shared with the team.
1. Verify `.vault_pass` is Git ignored by running the following command:
   ```
   grep '.vault_pass' .gitignore
   ```
1. Save the password into a new file, `.vault_pass`. 
1. Enable use of the password by completing the tasks marked with `TODO` in  `ansible.cfg`.
1. Encrypt the Ansible vault file, which will contain project secrets, with the following command:
   ```
   ansible-vault encrypt ansible/group_vars/all/vault.yml
   ```
1. Cook the Docker Compose files:
   ```
   ./ansible/cook_run_app.yml
   ```
1. Verify that the cooked Docker Compose files are correct by inspecting the files in the `.docker-compose-artifacts/run_app` directory.


### Verify tweaks
1. Build the Docker image, cook the Docker Compose file and related files, and run Docker Compose:
   ```
   ./run-app.sh
   ```
1. Verify the application is accessible at this url: http://localhost:8080/

### CircleCI
1. Ensure CircleCI can run tests and publish your Docker image by completing the tasks marked with `TODO` in `.circleci/config.yml`
1. Verify the following:
   * Log into Docker Hub dashboard to verify Docker image is created and is tagged with with Git SHA value when code is merged to `master` branch. Should also receive a Slack notification.
   * Log into Docker Hub dashboard to verify Docker image is created and is tagged with with Git tag value when code is a tag is applied to the `master` branch. Should also receive a Slack notification.
   * Log into CircleCI dashboard to verify linting and tests are run when PR are opened. Should also receive a Slack notification.

## Recommended tweaks
When the above items look good, it's a good idea set up Docker Compose configuration that runs unit or integration tests. This makes it possible to run tests for both local development and in the CI/CD tool. 

* If using Ansible, do the following:
   1. Copy the `ansible/cook_run_app.yml` to a new file named `ansible/cook_test_app.yml`.
   1. Copy the `ansible/roles/cook_run_app` directory to a new directory `ansible/roles/cook_test_app`
   1. Copy `./run-app.sh` to a new file named `./test-app.sh`
   1. Modify the newly created files as needed. ***NOTE***: To ensure the CI/CD fails and passes appropriately, Docker Compose's `--exit-code-from` must be used to track whether tests fail or pass.
   1. Run the tests by running:
      ```
      ./test-app.sh
      ```


* If you don't need Ansible, you can create another Docker Compose file appropriate for tests. 

Whether using Ansible or not, these patterns can be used to create more run-time configurations as needed.

## Replace README text
At this point, you'll have all of the basics for in place for this service. Now you can replace everything before the "Using this repo" section of this README with your own documenation and start adding code and configuration to your service.

# Using this repo

## Prerequisites
1. [Install Docker](https://github.com/dfmedia/docker-image-template/wiki/Installing-Docker).
1. [Install Ansible 2.9.X for Python3](https://docs.ansible.com/ansible/latest/reference_appendices/python_3_support.html).
1. Get the Ansible vault password for this project from another developer.
1. Save the Ansible Vault password into a file named, `.vault_pass`, at the root of the repo.   

## Running application locally
1. Build the Docker image, cook the Docker Compose file and related files, and run Docker Compose:
   ```
   ./run-app.sh
   ```
1. The following services will be available:
   * My App: http://localhost:8080/

## Publishing Docker image
1. Merge to the `master` branch.
1. The CI tool will build and push new Docker image to Docker Hub.
