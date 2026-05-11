# Deployment Guide

## Prerequisites
- Docker
- AWS CLI
- kubectl
- Terraform
- Git

## 1. Local Development

### Run locally
docker compose up --build

### Access
- Frontend: http://localhost:8080
- Backend: http://localhost:8000
- API Health: http://localhost:8000/health

## 2. AWS Infrastructure with Terraform

### Setup
cd terraform
terraform init
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars

### Outputs
- EKS Cluster name
- ECR Frontend URL
- ECR Backend URL
- VPC ID

## 3. Deploy to EKS

### Connect to EKS
aws eks update-kubeconfig --region ap-southeast-1 --name eks-hydrus-dev

### Create secrets
kubectl create secret generic hydrus-secrets \
  --from-literal=DATABASE_URL="postgresql://user:pass@db:5432/hydrus" \
  -n hydrus

### Apply manifests
kubectl apply -f k8s/
kubectl get pods -n hydrus

## 4. CI/CD Pipeline

### Trigger
- Push to main branch = deploy to production
- Push to develop branch = deploy to staging

### Required GitHub Secrets
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

## 5. Verify Deployment
kubectl get pods -n hydrus
kubectl get services -n hydrus
kubectl get ingress -n hydrus
