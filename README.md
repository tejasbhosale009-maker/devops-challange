# Jenkins Helm Deployment Pipeline

## Description
This Jenkins Declarative Pipeline automates deployment and rollback of a Dockerized application using Helm charts on Kubernetes.  
It supports:
- Deploying the latest Docker image to `dev`, `stag`, or `prod` environments.  
- Rolling back to a previous successful Docker tag or a specified tag.  
- Skipping subsequent stages after a rollback while marking the build as **SUCCESS**.  
- Security scanning and compliance reporting using static analysis tools and SARIF plugin.  

---

## Table of Contents
1. [Prerequisites](#prerequisites)  
2. [Pipeline Parameters](#pipeline-parameters)  
3. [Usage](#usage)  
4. [Rollback Mechanism](#rollback-mechanism)  
5. [Environment Setup](#environment-setup)  
6. [Security & Compliance](#security--compliance)  
7. [Notes](#notes)  
8. [License](#license)  
9. [Author](#author)  

---

## Prerequisites
- Jenkins installed with required agents:
  - `built-in` (default)
  - `mac-agent` (for terraform adn helm stage)
- Docker Hub account with credentials configured in Jenkins  to pull/push images   Add personal token will send in email
- Kubernetes cluster with Helm installed  
- Git repository access with SSH key configured in Jenkins  
  - You will get key in security/key folder add in jenkins Credentials
- Security scanning tools installed and configured in Jenkins:
  - `Trivy` for container image scanning  
  - `tfsec` for Terraform security checks  
  - `TFLint` for Terraform linting  
- Kubernetes secret created for images to be downloaded
`kubectl create secret docker-registry dockerpullsecret \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=tejasbhosale008 \
  --docker-password=dckr_pat_SOd-xfOjq0OgpJWxkRBdOrxsfl4 \
  --docker-email=tejasbhosale008@gmail.com`
---

## Pipeline Parameters

| Parameter        | Type    | Description                                                   | Default |
|-----------------|---------|---------------------------------------------------------------|---------|
| `ROLLBACK`       | Boolean | Enable rollback                                               | `false` |
| `ROLLBACK_TAG`   | String  | Docker tag to rollback to (optional; uses last successful if empty) | `''`    |
| `ROLLBACK_ENV`   | Choice  | Environment to rollback (`dev`, `stag`, `prod`)              | `dev`   |

---

## Usage

### Trigger Pipeline
1. Go to Jenkins → **Build with Parameters**.  

### Normal Deployment
- Leave `ROLLBACK` unchecked.  
- Pipeline will build and deploy the latest Docker tag to the selected environment.  

### Rollback Deployment
1. Check `ROLLBACK`.  
2. Optionally provide a `ROLLBACK_TAG`.  
3. Choose the environment: `dev`, `stag`, or `prod`.  
4. Pipeline will rollback to the specified tag or the last successful tag.  
5. Remaining stages are skipped, and build is marked as **SUCCESS**.  

---

## Rollback Mechanism
- The pipeline checks for a file named `last_successful_tag_<env>.txt` to determine the previous successful Docker tag if none is provided.  
- Executes the following Helm command for rollback:

```bash
helm upgrade --install hello-world ./kubernetes/hello-world-chart \
-f ./kubernetes/hello-world-chart/values.yaml \
-f ./kubernetes/hello-world-chart/values-<env>.yaml \
--namespace <env> \
--set image.repository=<DOCKERHUB_USERNAME>/helloworld \
--set image.tag=<rollbackTag> \
--wait
```