# Jenkins Docker Compose

### Description
Jenkins Docker image with Docker-compose pre-installed

### Docker-compose example

Environmental variables are optional, they are displayed in this example with default values applied.

```yml

  jenkins:
    image: zengoma/jenkins-docker-compose
    volumes:
      - /var/jenkins_home:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
    ports:
      - 8080:8080
      - 50000:50000
    environment:
      - JENKINS_HOME=/var/jenkins_home
      - DOCKER_COMPOSE_VERSION=1.24.0

``` 
Note: In this example we are mounting the docker.sock from the host machine. Make sure you understand the security risks. For this reason you also need to ensure that the `jenkins_home` folder is located in the exact same directory on the host and in the container because the docker daemon is going to look for your jenkins workspace on the host machine.

### Jenkinsfile example

```groovy
#!/bin/groovy
pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'sudo make build'
            }
        }
        stage('test'){
            steps{
                sh 'sudo docker-compose run app python manage.py test'
            }
        }
    }
}
```

You need to run any docker commands with sudo priveledges. This is to protect the host docker.sock. A consequence of this is that you cannot use the Jenkins docker agent (permission denied). You will be running any docker or docker-compose commands directly as shell commands as in the example.

### Folder permissions

Before bringing up the container you must run `sudo mkdir /var/jenkins_home && sudo chown -R 1000 /var/jenkins_home` to ensure that it belongs to the jenkins user.  
