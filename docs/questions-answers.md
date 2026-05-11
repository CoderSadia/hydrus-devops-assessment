# DevOps Assessment - Questions & Answers

## Task 1 - Docker Questions

### Q1. What optimizations did you apply to reduce Docker image size?
- Used multi-stage builds (builder + production stage)
- Used slim base images (python:3.12-slim, nginx:alpine)
- Copied only necessary files to final image
- Used --no-cache-dir for pip install
- Added .dockerignore to exclude unnecessary files

### Q2. What is the difference between a Docker image and a Docker container?
- Image: A read-only template/blueprint (like a class)
- Container: A running instance of an image (like an object)
- Many containers can run from one image
- Images are stored in registry, containers run on host

### Q3. How do you pass environment-specific values to a container securely?
- Use environment variables at runtime
- Use Kubernetes Secrets for sensitive data
- Use AWS Secrets Manager for production
- Never hardcode secrets in Dockerfile or source code

### Q4. How would you troubleshoot a container that exits immediately?
- Check exit code: docker inspect <container_id>
- Check logs: docker logs <container_id>
- Run interactively: docker run -it --entrypoint /bin/sh <image>
- Verify environment variables are set correctly

## Task 2 - Terraform Questions

### Q5. How would you manage separate dev, stage, and prod environments?
- Use separate .tfvars files (dev.tfvars, stage.tfvars, prod.tfvars)
- Use Terraform workspaces
- Use separate state files per environment
- Different node counts and instance sizes per environment

### Q6. What is Terraform state, and why is remote state important?
- State tracks what Terraform has created in real infrastructure
- Remote state (S3) allows team collaboration
- Prevents conflicts when multiple people run terraform
- State locking prevents simultaneous applies
- More secure than local state files

### Q7. How would you secure Terraform state and sensitive variables?
- Store state in S3 with encryption enabled
- Use DynamoDB for state locking
- Use IAM roles instead of access keys
- Mark sensitive variables with sensitive = true
- Never commit .tfstate files to Git

### Q8. What AWS networking/security considerations for EKS?
- Use private subnets for worker nodes
- Use Security Groups to restrict traffic
- Enable VPC CNI for pod networking
- Use IAM roles for service accounts (IRSA)
- Enable AWS GuardDuty for threat detection

## Task 3 - Kubernetes Questions

### Q9. Explain request flow from browser to backend API
Browser -> DNS -> Load Balancer -> Ingress Controller
-> frontend-service -> Frontend Pod
-> /api requests -> backend-service -> Backend Pod
-> Database

### Q10. Difference between Deployment and StatefulSet?
- Deployment: For stateless apps (frontend, backend)
  Pods are interchangeable, random names
- StatefulSet: For stateful apps (databases)
  Pods have stable names (postgres-0, postgres-1)
  Each pod gets its own persistent storage

### Q11. Difference between ClusterIP, NodePort, LoadBalancer?
- ClusterIP: Internal only, no external access (backend, db)
- NodePort: External via node IP and port (testing only)
- LoadBalancer: Public IP via cloud load balancer (frontend)

### Q12. How to troubleshoot CrashLoopBackOff?
- kubectl describe pod <name> -n hydrus
- kubectl logs <name> -n hydrus --previous
- Check exit code for OOM kill (137)
- Verify environment variables
- Check resource limits

### Q13. How do readiness and liveness probes improve reliability?
- Liveness: Restarts container if app is frozen/dead
- Readiness: Stops traffic to pod if not ready
- Together they ensure zero-downtime deployments
- Prevent 503 errors during pod startup

### Q14. Which metrics for HPA and why?
- CPU utilization (60%): API is compute-intensive
- Memory utilization (70%): Prevent OOM kills
- CPU spikes directly correlate with response time

## Task 4 - CI/CD Questions

### Q15. Explain CI vs CD
- CI (Continuous Integration): Auto build and test on every push
- CD (Continuous Delivery): Auto deploy to environment after CI passes
- CI catches bugs early, CD ensures fast reliable delivery

### Q16. How to implement rollback?
- kubectl rollout undo deployment/backend -n hydrus
- Keep previous image tags in ECR
- Smoke test after deploy, auto rollback if fails
- Use maxUnavailable: 0 for safe rolling updates

### Q17. Rolling update vs blue-green deployment?
- Rolling: Gradually replace old pods with new ones
  Zero downtime, resource efficient, built into Kubernetes
- Blue-Green: Two identical environments, switch traffic at once
  Instant rollback, needs 2x resources

### Q18. How to protect pipeline secrets?
- Store in GitHub Secrets (encrypted)
- Use IAM roles with OIDC, not access keys
- Never print secrets in logs
- Use environment-level secrets with approval gates

## Task 5 - Monitoring Questions

### Q19. Possible root causes for high latency/503 errors
- Insufficient CPU/memory resources
- Database connection pool exhausted
- Memory leak causing OOM kills
- HPA not scaling fast enough
- Application bug (N+1 queries, blocking IO)
- Network issues between pods

### Q20. Step-by-step investigation
1. kubectl get pods -n hydrus
2. kubectl top pods -n hydrus
3. kubectl describe hpa -n hydrus
4. kubectl logs <pod> --previous
5. kubectl get endpoints -n hydrus
6. Check Grafana dashboards
7. Check CloudWatch metrics
8. Check database slow query logs

### Q21. Useful commands
kubectl get pods -n hydrus
kubectl top pods -n hydrus
kubectl logs <pod> -n hydrus --previous
kubectl describe pod <pod> -n hydrus
kubectl rollout undo deployment/backend -n hydrus
aws eks describe-cluster --name eks-hydrus-dev
top, free -h, df -h

### Q22. Logs and metrics to check first
1. kubectl get pods - how many are crashing
2. kubectl top pods - which pods are saturated
3. Grafana error rate dashboard
4. kubectl logs --previous - root cause

### Q23. Immediate mitigation
- kubectl rollout undo (if bad deployment)
- kubectl scale deployment backend --replicas=6
- Increase memory limits if OOM
- Restart ingress controller if routing broken

### Q24. Long-term preventive actions
- Load testing before production deployment
- Right-size resources using VPA recommendations
- Add database connection pooling (PgBouncer)
- Implement circuit breaker pattern
- Set up proper SLO and error budget alerts
- Use KEDA for better autoscaling
