# AWS TWO TIER ARCHITECTURE USING TERRAFORM
## PROJECT OVERVIEW
This project implements a secure, highly available two-tier web application architecture on AWS using Terraform. The infrastructure follows AWS best practices for scalability, security, and reliability, featuring a public web tier and a private database tier.

![AWS Two-Tier Architecture](./images/architecture-diagram.jpeg)


## Architecture Components
### Web Tier (Public Layer):

* Application Load Balancer (ALB) - Distributes incoming web traffic

* Auto Scaling Group - Automatically scales EC2 instances

* EC2 Instances - Hosts the web application in public subnets

* Public Subnets - Across multiple Availability Zones

* Internet Gateway - Provides internet access

### Data Tier (Private Layer):

* Amazon RDS - Managed relational database service

* Private Subnets - Isolated subnets with no direct internet access

* Security Groups - Fine-grained firewall rules between tiers

## Key Features
### High Availability
  * Multi-AZ deployment across different data centers

* Auto-scaling that adds/removes servers automatically

* Load balancer distributes traffic evenly

### Security 
* Web servers and database in separate secure zones

* Database hidden from public internet

* Firewall rules control all traffic

### Easy Management
* One-click deployment with Terraform

* Entire infrastructure defined as code

* Easy to modify and reproduce

### Cost Effective
* Pay only for what you use

* Auto-scaling saves money during low traffic


### Scalable
* Handles traffic spikes automatically

* Grows with your application needs

* No downtime when scaling

* Database read replicas for heavy workloads

## DEPLOYMENT
### Step 1: Clone and Navigate
```bash
git clone https://github.com/SAYAND-VENGILATT/Aws-two-tier-infrastructure.git
cd aws-two-tier-infrastructure
```
### Step 2: Initialize Terraform
```bash
terraform init
```
### Step 3: Review Plan
```bash
terraform plan
```
### Step 4: Apply Infrastructure
```bash
terraform apply --auto-approve
```
### Cleanup
```bash
terraform destroy --auto-approve
```
## Future Improvements
* CI/CD Pipeline - Automated testing and deployment

* HTTPS Support - SSL/TLS certificates with ACM

* CloudFront CDN - Global content delivery

* WAF Integration - Web application firewall

* Monitoring - Enhanced CloudWatch dashboards
