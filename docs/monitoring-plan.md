# Monitoring Plan

## Tools
- Prometheus: Metrics collection
- Grafana: Visualization
- AlertManager: Alerts

## What to Monitor
- CPU and Memory usage
- Pod health
- API response time
- Error rate

## Alerts
- CPU > 80% = Warning
- Pod crash = Critical
- API error > 5% = Critical

## Useful Commands
kubectl top pods -n hydrus
kubectl get pods -n hydrus
kubectl logs <pod-name> -n hydrus
kubectl describe pod <pod-name> -n hydrus
kubectl rollout undo deployment/backend -n hydrus
