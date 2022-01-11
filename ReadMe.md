# Docker ansible

Docker image to use [`ansible`](https://www.ansible.com/) and `ssh` in a CI :+1:

[![Docker Stars](https://img.shields.io/docker/stars/gableroux/ansible.svg)](https://hub.docker.com/r/gableroux/ansible)
[![Docker Pulls](https://img.shields.io/docker/pulls/gableroux/ansible.svg)](https://hub.docker.com/r/gableroux/ansible)
[![Requirements Status](https://requires.io/github/GabLeRoux/docker-ansible/requirements.svg?branch=main)](https://requires.io/github/GabLeRoux/docker-ansible/requirements/?branch=main)

## Usage

### Command line

```bash
docker run --rm -it gableroux/ansible:2.9.19rc1
```

### gitlab-ci example

```yaml
.ansible:2.9.19rc1
  stage: deploy
  when: manual
  image: gableroux/ansible:2.9.19rc1
  before_script:
    # https://docs.gitlab.com/ee/ci/ssh_keys/
    - eval $(ssh-agent -s)
    - mkdir ~/.ssh/
    - chmod 700 ~/.ssh
    - echo "$SSH_CONFIG" > ~/.ssh/config
    - echo "$SSH_KNOWN_HOSTS" > ~/.ssh/known_hosts
    - chmod 644 ~/.ssh/known_hosts
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null

deploy-example-master:
  <<: *ansible
  script:
    - ansible --version
    - ansible-playbook -i host-example deploy.yml
  only:
    - master
```

## FAQ

### How to deploy new docker image

There is a script in `scripts` that reads values from `versions.txt` and runs required commands to push to the repository with tags and trigger docker hub. :v:

### Why bother using a docker image

Installing with `pip` is fine, but pulling this image is faster.

### Why not use an official ansible image?

[As described here in the short description](https://store.docker.com/r/ansible/ansible):

> Images for automated testing of Ansible. They do not include Ansible and are not for end users.

The official image is used to run tests for the ansible project. I wish they had and official image for actually running ansible.

### My version is not there, what can I do?

Have a look at [hub.docker.com/r/gableroux/ansible/tags](https://hub.docker.com/r/gableroux/ansible/tags), most versions are available. There are automatic PRs setup for upgrading the project so the version you're looking for should be there. If for some reason, it's still not there, you can fork the project, replace `ENV` and push your own image. Image building is done trough github-actions.

### Can I contribute?

Yes, why not?

### There are already a lot of ansible docker images out there, why a new one?

I don't trust people when it comes to running critical code against infrastructure. If you wish to use this, I recommend you to fork it and build your own. There are many good alternatives, notably [William-Yeh/docker-ansible](https://github.com/William-Yeh/docker-ansible), but I found it was kind of big or doing too many things. This docker image is based on alpine and is very minimal and small :)

### How is this image deployed to docker hub?

I'm using [github-actions](https://github.com/features/actions). See [`.github/workflows/`](https://github.com/gableroux/docker-ansible/tree/main/.github/workflows/)

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)
