kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/standard-install.yaml

helm repo add cilium https://helm.cilium.io/
helm repo update
helm upgrade --install \
    cilium cilium/cilium \
    --version 1.17.5 \
    --namespace kube-system \
    --values=chart-values.yaml \
    --wait

kubectl apply -f lb.yaml
kubectl label namespaces kube-system shared-gateway-access=true
kubectl apply -f httproute.yaml