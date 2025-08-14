### Steps for setting up

- Dependencies :
 - You will need a Docker desktop installed on your machine.
 - Plus you will need minikube installed on your laptop.

**Steps to install above requirements on your laptop **
1. [Docker desktop](https://www.docker.com/products/docker-desktop/ "Docker desktop")
2. Click on Download Docker Desktop and choose package accourding to your laptop OS and architecture.
3. After that install it on your local machine.
4. [Minikube](http://https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Fx86-64%2Fstable%2Fbinary+download "Minikube")
5. Download minikube as per your laptop requirement i.e OS and architecture.

# Setting up Jenkins continer Master
1. Clone this repo  git@github.com:tejasbhosale009-maker/devops-challange.git
2. Run command `docker volume create jenkins_home`
3. Inside jenkins directory fire below command
```
docker build -t jenkins:latest
docker-compose up -d
```
4. This will start jenkins container on your laptop you can access it http://127.0.0.1:8080

# Setting up Jenkins agent 
1. Go to manage jenkins
2. Click on Nodes
3. Click on Add node
4. Provide Node name and select Permanent agent
5. Provide Remote Dir : in my case /Users/username/jenkins_agent/
6. Give useful label name
7. After agent added click on agent and it will give you few command to run copy it run on your laptop on background mode.
Eg- This is just example secret will be different
`curl -sO http://127.0.0.1:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://127.0.0.1:8080/ -secret 2ff6a725ae914d321364329aa2fcde8220ea6ff4bf82a0678cb8440f76929817 -name as -webSocket -workDir "/usr/tejas/"`

# Terraform setup
[Terraform](http:/https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_darwin_amd64.zip/ "Terraform")
Downlaod and install

## Setup helm
- Setup helm on laptop
`curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
`

# Setting up minikube
1. Create a new item , enter proper name and choose pipeline
2. Repo which you cloned in earlier step go to terraform folder copy Jenkinsfile code and paster in this.
3. As its local setup when you run pipeline choose dev as env in box.
4. This will setup minikube (Note as mine is mac i added agent as mac so make sure to keep name same or terraform command will not run)
5. ```
  kubectl create secret docker-registry dockerpullsecret \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=tejasbhosale008 \
  --docker-password=dckr_pat_SOd-xfOjq0OgpJWxkRBdOrxsfl4 \
  --docker-email=tejasbhosale008@gmail.com
  ```
##### Common Issues
- As Jenkins is container so when you try to build images it will fail as from jenkins docker will try to connect to docker deamon and it will not able to connect so i used docker in docker technology (dind) to fix this issue
-  Second is when you run terraform and helm and kubernets command they will also fail as minikube always start on 127.0.0.1:port and for any container 127.0.0.1 is container itself so it will try to execute command their but it will not able to connect to kubectl. So i configured nodes and added my local laptop as agent .
- Third issue is that we clone repo in jenkins so when you try to run helm and kubernetes command from pipeline as they are running from your mac agent mac agent dont have repo cloned so you have to use stash and unstash method to copy repo to mac workspace.
###End