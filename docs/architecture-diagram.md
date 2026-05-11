# Architecture Diagram

## Request Flow
User Browser
    ↓
AWS Load Balancer
    ↓
Nginx Ingress Controller
    ↓
EKS Cluster
    ├── Frontend Pod (x2 replicas)
    │       ↓
    ├── Backend Pod (x2-10 replicas via HPA)
    │       ↓
    └── PostgreSQL Pod

## CI/CD Flow
Developer pushes code
    ↓
GitHub Actions triggered
    ↓
Run Tests
    ↓
Build Docker Images
    ↓
Push to AWS ECR
    ↓
Deploy to EKS
    ↓
Smoke Test
    ↓
Live!

## Components
- AWS EKS: Kubernetes Cluster
- AWS ECR: Docker Image Registry
- AWS VPC: Private Network
- Nginx Ingress: Traffic routing
- Frontend: HTML/JS served by nginx
- Backend: Python FastAPI
- Database: PostgreSQL
- HPA: Auto scaling (2-10 replicas)
- GitHub Actions: CI/CD Pipeline
