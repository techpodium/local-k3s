#!/bin/bash

kubectl delete -f combined.yaml -n wpproxy
kubectl apply -f combined.yaml -n wpproxy
kubectl get all -n wpproxy
sleep 5
kubectl get all -n wpproxy
sleep 5
curl http://192.168.18.23:32000/wp-admin
