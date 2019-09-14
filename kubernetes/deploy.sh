#!/bin/bash

if [ "$1" = "delete" ]; then
    echo "Clearing the cluster."
    kubectl delete -f ./ingress/00-namespace.yml
    echo "Parse microservice is removed from the cluster"
elif [ "$1" = "create" ]; then
    echo "Deploying Parse microservice to kubernetes cluster"
    kubectl create -R -f ./ingress/
    kubectl create -R -f ./mongo/
    kubectl create -R -f ./parse/
    kubectl create -R -f ./grafana/
    kubectl create -R -f ./kube_stats/
    kubectl create -R -f ./node_exporter/
    kubectl create -R -f ./prometheus/   
    kubectl create -R -f ./alerting_server/ 
    echo "Deployed! Access microservice at "
    kubectl get ingress -n microservice | awk '{ print $3 }'
fi