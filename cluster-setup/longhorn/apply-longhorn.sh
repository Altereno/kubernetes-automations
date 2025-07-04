helm repo add longhorn https://charts.longhorn.io
helm repo update
kubectl apply -f longhorn-namespace.yaml
helm upgrade --install \
    longhorn longhorn/longhorn \
    --version 1.9.0 \
    --namespace longhorn-system
