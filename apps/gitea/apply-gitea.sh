helm repo add gitea-charts https://dl.gitea.com/charts/
helm repo update
helm upgrade --install \
    gitea gitea-charts/gitea \
    --namespace gitea \
    --create-namespace \
    --values=chart-values.yaml

kubectl label namespaces gitea shared-gateway-access=true
kubectl apply -f http-route.yaml