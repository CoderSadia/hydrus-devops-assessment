# Troubleshooting Guide

## Pod CrashLoopBackOff
kubectl get pods -n hydrus
kubectl logs <pod-name> -n hydrus --previous
kubectl describe pod <pod-name> -n hydrus

## High CPU Usage
kubectl top pods -n hydrus
kubectl top nodes

## 503 Errors
kubectl get endpoints -n hydrus
kubectl get ingress -n hydrus

## Rollback Deployment
kubectl rollout undo deployment/backend -n hydrus
kubectl rollout undo deployment/frontend -n hydrus

## Check All Resources
kubectl get all -n hydrus
