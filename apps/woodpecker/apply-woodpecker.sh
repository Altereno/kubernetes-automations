kubectl apply -f namespace.yaml
helm upgrade --install \
    woodpecker oci://ghcr.io/woodpecker-ci/helm/woodpecker \
    --version 3.1.2 \
    --namespace woodpecker \
    --values=chart-values.yaml

kubectl label namespaces woodpecker shared-gateway-access=true
kubectl apply -f http-route.yaml