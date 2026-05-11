# Hydrus DevOps Assessment

## Project Overview
A production-style web platform on AWS using Docker, Terraform, Kubernetes, and CI/CD.

## Tech Stack
- Frontend: HTML/CSS/JS (nginx)
- Backend: Python FastAPI
- Database: PostgreSQL
- Cloud: AWS (EKS, ECR, VPC)
- IaC: Terraform
- CI/CD: GitHub Actions
- Orchestration: Kubernetes

## Run Locally
docker compose up --build

## Access
- Frontend: http://localhost:8080
- Backend: http://localhost:8000

## Test API
curl http://localhost:8000/health
curl http://localhost:8000/api/items

## Author
Sadia - DevOps Engineer
