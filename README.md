Here is a human-readable `README.md` for your project based on the architecture you've described:

---

```markdown
# Basic Yii2 Application with Docker Swarm, Ansible, and GitHub Actions CI/CD

This project demonstrates the deployment of a minimal Yii2 PHP web application using Docker Swarm on an Amazon Linux 2023 EC2 instance. It includes infrastructure automation with Ansible and a full CI/CD pipeline using GitHub Actions.

---

## Table of Contents

- [Overview](#overview)
- [Setup Instructions](#setup-instructions)
- [Assumptions](#assumptions)
- [CI/CD Pipeline](#cicd-pipeline)
- [Testing the Deployment](#testing-the-deployment)
- [Project Structure](#project-structure)

---

## Overview

- The Yii2 PHP application is containerized using Docker.
- NGINX runs on the EC2 host (not in a container) and acts as a reverse proxy.
- Docker Swarm is used for deploying the app as a service.
- Ansible automates the provisioning of Docker, NGINX, and deployment tasks.
- GitHub Actions automates image builds, pushes to Docker Hub, and SSH-based service updates.

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/basic-yii2-app.git
cd basic-yii2-app
```

### 2. Configure Ansible

Edit the Ansible inventory file:

```ini
[swarm_nodes]
your.ec2.public.ip ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/your-key.pem ansible_become_method=sudo ansible_ask_pass=false
```

### 3. Install Ansible Dependencies on Local Machine

Ensure Python 3, `pip`, and `ansible-core` are installed. Then:

```bash
pip install docker
ansible-galaxy collection install community.docker
```

### 4. Run Ansible Playbook

From the `ansible/` directory:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

This will:

- Install Docker, Docker Compose, and NGINX
- Initialize Docker Swarm
- Deploy the application as a service
- Configure NGINX as a reverse proxy

---

## Assumptions

- You are using Amazon Linux 2023 on your EC2 instance.
- Your EC2 instance has a public IP and SSH access is enabled.
- Docker Hub credentials are stored in GitHub Secrets:
  - `DOCKERHUB_USERNAME`
  - `DOCKERHUB_TOKEN`
- SSH credentials are also stored in GitHub Secrets:
  - `SSH_PRIVATE_KEY`
  - `EC2_HOST`
  - `EC2_USER`
- The Dockerfile is located under the `docker/` directory.
- The app is served on port `80` through NGINX reverse proxy.

---

## CI/CD Pipeline

GitHub Actions is configured to:

- Trigger on push to the `main` branch
- Calculate the next numeric tag for the Docker image
- Tag the image as both the next version and `latest`
- Push both tags to Docker Hub
- SSH into the EC2 host and update the Docker Swarm service

You can find the CI/CD workflow in `.github/workflows/deploy.yml`.

---

## Testing the Deployment

1. **After CI/CD runs**, open your browser and visit:

```
http://<your-ec2-public-ip>
```

2. You should see the Yii2 welcome page.

3. To test redeployment, make a change to the Yii2 code and push it to the `main` branch. GitHub Actions will:

- Build a new Docker image
- Tag it incrementally (e.g., `basic-yii2-app:2`)
- Push the image
- Pull it on the EC2 instance and update the service

---

## Project Structure

```
basic-yii2-app/
├── .github/workflows/deploy.yml        # GitHub Actions CI/CD
├── ansible/
│   ├── inventory.ini
│   ├── playbook.yml
│   └── roles/
│       ├── docker/
│       ├── nginx/
│       ├── php/
│       └── swarm/
├── docker/
│   ├── Dockerfile
│   └── yii2.ini
├── src/                                # Yii2 source code
├── .dockerignore
├── .gitignore
├── docker-compose.yml                  # Optional
└── README.md
```

---

## License

This project is provided for educational and testing purposes.
```

---

