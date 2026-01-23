# End to End Production Grade Deployment on AWS ECS Fargate - [Threat-composer]
 ---
A production-grade containerised application deployment on AWS ECS Fargate, demonstrating Infrastructure as Code (IaC) best practices, GitOps workflows, and secure CI/CD automation.

##  Project Overview

This project showcases the deployment of a React-based threat modelling application to AWS using modern DevOps practices. The infrastructure is fully automated, secure, and follows the principle of least privilege throughout.

### What I Built:

- **Fully automated CI/CD pipeline** using GitHub Actions with OIDC authentication (zero static credentials)

- **Production-grade ECS Fargate deployment** with task definitions, services, and autoscaling

- **Infrastructure as Code (IaC)** using Terraform to provision VPC, IAM, ECS, ALB, and supporting AWS resources

- **GitOps-style workflow** where infrastructure and application changes are applied through Git commits and pull requests

##  Tech Stack

### Cloud & Infrastructure
- **AWS ECS Fargate** – Serverless container orchestration for production workloads  
- **Amazon ECR** – Secure container image registry  
- **AWS VPC** – Isolated networking with public and private subnets  
- **Application Load Balancer (ALB)** – Traffic routing, health checks, and scalability  
- **AWS IAM** – Least-privilege access control and role-based security  

### Infrastructure as Code (IaC)
- **Terraform** – Declarative provisioning and lifecycle management of AWS resources  
- **Terraform Modules** – Modular, reusable, and environment-agnostic infrastructure components  

### CI/CD, GitOps & DevSecOps
- **GitHub Actions** – Automated CI/CD pipelines for build, scan, and deployment  
- **OIDC Authentication** – Secure AWS authentication without long-lived credentials  
- **GitOps Workflow** – Git as the single source of truth for infrastructure and deployments  
- **Trivy** – Container image and filesystem vulnerability scanning  
- **Checkov** – Policy-as-code and static security analysis for Terraform IaC
- **TFLint** – Linter for Terraform code to enforce best practices and detect potential issues early  


###  Containers & Application
- **Docker** – Containerised application packaging  
- **ECS Task Definitions** – Declarative runtime configuration for containers

## Project Structure
```
threat-composer
└── .github/workflows/
    ├── apply.yml
    ├── destroy.yml
    ├── docker.yml
    └── plan.yml
├── LICENSE.txt
├── README.md
├── app/
│   ├── Dockerfile
│   ├── .gitignore
│   │
└── terraform/
    ├── bootstrap/
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── provider.tf
    │  
    ├── main.tf
    ├── modules/
    │   ├── acm/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── alb/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── ecr/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── ecs/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── sg/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   └── vpc/
    │       ├── main.tf
    │       ├── outputs.tf
    │       └── variables.tf
    ├── provider.tf
    ├── terraform.tfvars
    └── variables.tf
``` 

## Running the Application Locally

### Prerequisites

- Node.js 20+
- Yarn package manager
- Docker (for containerised run)

### Option 1: Without Docker (Development Mode)
```bash
yarn install
yarn build
yarn global add serve
serve -s build

#yarn start
http://localhost:3000
```

### Option 2: With Docker (Production-like)
```bash
cd app
docker build -t threatapp:local .
docker run -d -p 3000:3000 threat:local 
# Application runs at http://localhost:3000
```
### Local Health Check

![Local Health Check Passed](https://github.com/AamirKT/threat-composer/blob/main/images/local%20health%20check.png?raw=true)

## Docker Build Performance

This project compares **single-stage** and **multi-stage Docker builds** for the application to demonstrate container optimisation in a production deployment.

| Build Type      | Disk Usage | Image Size | Build Time | Notes |
|-----------------|-----------|------------|------------|-------|
| **Single-stage** | 4.34 GB    | 872 MB     | 8 min 54s | Local build; node:20-latest base image used; all dependencies and build artifacts remain in final image |
| **Multi-stage**  | 299 MB    | 69 MB      | 4 min 35s | Production-ready build; lightweight node:20-alpine image used; unnecessary build tools excluded ||

**Verified Docker Images**

![Docker image verification](https://github.com/AamirKT/threat-composer/blob/main/images/docker%20image%20comparison%20data.png?raw=true)

**Multi-stage builds offered significant improvements:**
- **Lowered disk usage by 93%**  
- **Shrunk image size by 92%**  
- **Accelerated deployment with 49% faster build time**

## Project Structure
```
threat-composer
└── .github/workflows/
    ├── apply.yml
    ├── destroy.yml
    ├── docker.yml
    └── plan.yml
├── LICENSE.txt
├── README.md
├── app/
│   ├── Dockerfile
│   ├── .gitignore
│   │
└── terraform/
    ├── bootstrap/
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── provider.tf
    │  
    ├── main.tf
    ├── modules/
    │   ├── acm/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── alb/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── ecr/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── ecs/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── sg/
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   └── vpc/
    │       ├── main.tf
    │       ├── outputs.tf
    │       └── variables.tf
    ├── provider.tf
    ├── terraform.tfvars
    └── variables.tf
```
## CI/CD Pipeline (GitHub Actions)

This project features a **fully automated, secure CI/CD pipeline** using GitHub Actions with **OIDC authentication** and **GitOps principles**. Each workflow is designed to manage specific stages of application lifecycle, from building containers to provisioning and destroying infrastructure on AWS ECS Fargate.

### Workflow Overview

1. **Docker Build & Push (`docker.yml`)**

![docker.yml](https://github.com/AamirKT/threat-composer/blob/main/images/docker%20workflow%20success.png?raw=true)

   - Builds Docker images for the application
   - Uses **trivy** to scan image for security vulnerabilities  
   - Pushes images to **Amazon ECR**  

2. **Terraform Plan (`plan.yml`)**

![plan.yml](https://github.com/AamirKT/threat-composer/blob/main/images/plan%20workflow%20success.png?raw=true)

   - Executes `terraform plan` to preview infrastructure changes  
   - Runs **TFLint**, to catch potential issues and enforce Terraform best practices
   - Integrates **Checkov** to scan Terraform code for misconfigurations
   - Runs `terraform fmt` and `terraform validate` to catch errors and keep code consistent.
      
3. **Terraform Apply (`apply.yml`)**

![apply.yml](https://github.com/AamirKT/threat-composer/blob/main/images/apply%20workflow%20success.png?raw=true)

   - Applies approved Terraform changes to provision/update AWS infrastructure  
   - Deploys updated containers to **AWS ECS Fargate**
   - Executes **Post-Deploy Health Check** that fails the pipeline if the health check does not pass

4. **Terraform Destroy (`destroy.yml`)**

![destroy.yml](https://github.com/AamirKT/threat-composer/blob/main/images/destroy%20workflow%20success.png?raw=true)

   - Tears down infrastructure safely when required  
   - Ensures **clean removal** of AWS resources without leaving orphaned services  

## Security & Compliance

- **OIDC-based authentication** between GitHub Actions and AWS, eliminating the use of long-lived static credentials  
- **Least-privilege IAM roles and policies** for CI/CD pipelines, ECS tasks, and supporting AWS services  
- **Infrastructure security scanning** using **Checkov** to detect misconfigurations and enforce policy-as-code on Terraform resources  
- **Container vulnerability scanning** with **Trivy** to identify known CVEs in container images and filesystems before deployment  
- **Secrets management** using AWS Secrets Manager to avoid hard-coded secrets  
- **Network isolation** via VPC design with public and private subnets and controlled ingress through an Application Load Balancer  
- **Auditability and traceability** through GitOps workflows, where all infrastructure and deployment changes are version-controlled in Git

---

## Challenges Encountered & Solutions

- **Challenge:** Ensuring secure CI/CD without using long-lived AWS credentials  
  **Solution:** Implemented **OIDC authentication** in GitHub Actions to authenticate dynamically with AWS, eliminating static secrets.

- **Challenge:** Detecting misconfigurations in Terraform before applying changes  
  **Solution:** Integrated **Checkov** and **TFLint** into the CI pipeline to catch security and best-practice issues during `terraform plan`.

- **Challenge:** Preventing vulnerabilities in container images  
  **Solution:** Added **Trivy** scans in the pipeline to identify and remediate CVEs before deployment.

- **Challenge:** Managing infrastructure drift and environment consistency  
  **Solution:** Adopted **GitOps workflow**, making Git the single source of truth for both infrastructure and application deployments.

## Lessons Learned & Improvements

- Learned to implement **GitOps workflow with secure OIDC authentication** for CI/CD pipelines.  
- Gained hands-on experience with **Terraform modularization** and deploying production-grade **AWS ECS Fargate workloads**.  
- Improved **security posture** by integrating **Trivy** and **Checkov** into CI/CD pipelines.  
- Learned best practices for **least-privilege IAM roles** and network isolation in AWS.
  
- **Areas to improve:**
  - Implement **automated rollback strategies** for ECS deployments to minimize downtime on failed releases.  
  - Enhance **monitoring and alerting**, potentially integrating CloudWatch Alarms or Prometheus/Grafana dashboards.  
  - Expand **integration testing** for containers before production deployment.  
  - Consider **multi-environment deployments** (dev/staging/prod) with fully automated promotion pipelines.  












 
