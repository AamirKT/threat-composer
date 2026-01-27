# End to End Production Grade Deployment on AWS ECS Fargate (Threat composer)
 ---
A production-grade containerised application deployment on AWS ECS Fargate, demonstrating Infrastructure as Code (IaC) best practices, GitOps workflows, and secure CI/CD automation.

##  Project Overview

This project showcases the deployment of a React-based threat modelling application to AWS using modern DevOps practices. The infrastructure is fully automated, secure, and follows the principle of least privilege throughout.

## Architecture

![Architecture Diagram](https://github.com/AamirKT/threat-composer/blob/main/images/threat-composer-architecture.drawio.png?raw=true)

## Demo

https://github.com/user-attachments/assets/b91392e8-3f26-475d-b7ce-82c20e4268ec 

---
## What is Threat Composer?

Threat Composer is a web-based threat modelling application that helps teams design, visualise, and manage security threats across modern systems.

It enables engineers and security practitioners to identify threats, track mitigations, and document assumptions early in the design process using an interactive, cloud-native platform.

---

### What I Built:

- **Fully automated CI/CD pipeline** using GitHub Actions with OIDC authentication (zero static credentials)

- **Production-grade ECS Fargate deployment** with task definitions and services

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
---
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
---
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

---

## Docker Build Performance

This project compares **single-stage** and **multi-stage Docker builds** for the application to demonstrate container optimisation in a production deployment.

| Build Type      | Disk Usage | Image Size | Build Time | Notes |
|-----------------|-----------|------------|------------|-------|
| **Single-stage** | 4.34 GB    | 872 MB     | 8 min 54s | Local build; node:20-latest base image used; all dependencies and build artifacts remain in final image |
| **Multi-stage**  | 299 MB    | 69 MB      | 3 min 53s | Production-ready build; lightweight node:20-alpine image used; unnecessary build tools excluded ||

**Multi-stage builds offered significant improvements:**
- **Lowered disk usage by 93%**  
- **Shrunk image size by 92%**  
- **Accelerated deployment with 56% faster build time**

![Docker image verification](https://github.com/AamirKT/threat-composer/blob/main/images/docker%20image%20comparison%20data.png?raw=true)

---

##  Container Registry (ECR)

Docker images are stored in Amazon Elastic Container Registry, providing secure, scalable image storage with IAM-based authentication.

![ECR image ](https://github.com/AamirKT/threat-composer/blob/main/images/ecr-image.png?raw=true)

---

## TLS Certificate (ACM)

SSL/TLS certificate managed by AWS Certificate Manager with DNS validation via Route53. The certificate covers `aamir-ecs.com` and is automatically renewed by AWS.

![ACM Certificate](https://github.com/AamirKT/threat-composer/blob/main/images/acm%20certificate%20confirmation.png?raw=true)

---

## Production Deployment

The application is deployed to ECS Fargate behind an Application Load Balancer with TLS termination.

### Live Endpoint
```
https://aamir-ecs.com
https://aamir-ecs.com/health.json
```
### Verified Production Deployment

Application accessible via HTTPS on custom domain:

![Application Running on HTTPS](https://github.com/AamirKT/threat-composer/blob/main/images/threat-composer%20web%20page.png?raw=true)

---
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

---

## Security & Compliance

Security and compliance are built into every stage of the CI/CD and infrastructure lifecycle:

- **OIDC-based authentication** between GitHub Actions and AWS, eliminating long-lived static credentials and reducing credential exposure risk.
- **Least-privilege IAM design**, with tightly scoped roles and policies for CI/CD pipelines, ECS tasks, and supporting AWS services.
- **Infrastructure security scanning** using **Checkov** to detect misconfigurations and enforce policy-as-code for Terraform-managed resources.
- **Container vulnerability scanning** with **Trivy** to identify known CVEs in container images and filesystems before deployment.
- **Secure secrets management** using **GitHub secrets**, avoiding hard-coded credentials in code or pipelines.
- **Network isolation and access control** through VPC architecture with public and private subnets, controlled ingress via an Application Load Balancer.
- **Auditability and traceability** enabled by GitOps workflows, ensuring all infrastructure and deployment changes are version-controlled and auditable in Git.

---

## Challenges Encountered & Solutions

### 1. IAM Permission Issues During Terraform Apply
**Challenge:**  
Terraform `plan` and `apply` failed with multiple `403 AccessDenied` errors across EC2, ECS, IAM, ECR, Route 53, and ACM.

**Solution:**  
The GitHub Actions IAM role was updated with the required permissions. After fixing IAM policies, both were run successfully.

---

### 2. Terraform State Locked in S3 After Failed Apply
**Challenge:**  
A failed `terraform apply` left the remote S3 state file locked, preventing subsequent runs.

**Solution:**  
The state lock was manually released using `terraform force-unlock`, after which `terraform apply` could run normally again.

---

### 3. ECS Tasks Stuck in `PENDING` / Image Pull Failures
**Challenge:**  
ECS tasks failed to start due to missing container images in ECR (`CannotPullContainerError`).

**Solution:**  
Ensured the Docker image was built and pushed to ECR **before** updating the ECS service, using the GitHub commit SHA consistently for tagging.

---

### 4. ALB Health Checks Failing During Deployment
**Challenge:**  
The application returned `503` errors immediately after deployment, causing the CI pipeline to fail.

**Solution:**  
Added retries to the post-deploy health check, allowing ECS tasks time to register as healthy behind the ALB.

---

### Key Takeaways:

- Terraform requires both read and write IAM permissions to manage infrastructure safely.
- Failed Terraform applies can leave remote state locked, requiring manual recovery.
- ECS deployments depend on correct image tagging and build order in CI/CD pipelines.
- ALB-backed ECS services need retry-based health checks to avoid false failures.
- Partial infrastructure creation is possible even when Terraform exits with errors.
- Infrastructure as Code enables fast recovery once foundational issues are fixed.

---
  
### Future improvements:

  - Include ECR repository provisioning in the Terraform bootstrap module before the main deployment.
  - Introduce environment separation (dev/stage/prod) using Terraform workspaces.
  - Enhance **monitoring and alerting**, potentially integrating CloudWatch Alarms or Prometheus/Grafana dashboards.  
  - Expand **integration testing** for containers before production deployment.

   ---

## Author

**Aamir Tamuri**

[LinkedIn](https://www.linkedin.com/in/aamir-tamuri-491244349/) | [GitHub](https://github.com/AamirKT)

DevOps engineer building production-grade cloud infrastructure and CI/CD pipelines. This project demonstrates automated, secure, and scalable deployment of cloud-native applications.

