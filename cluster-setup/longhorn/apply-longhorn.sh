kubectl apply -f longhorn-namespace.yaml

helm repo add longhorn https://charts.longhorn.io
helm repo update
helm upgrade --install \
    longhorn longhorn/longhorn \
    --version 1.9.0 \
    --namespace longhorn-system

kubectl label namespaces longhorn-system shared-gateway-access=true
kubectl apply -f httproute.yaml