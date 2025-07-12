kubectl create namespace argocd
kubectl label ns argocd shared-gateway-access=true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch configmap argocd-cmd-params-cm -n argocd --type merge -p '{"data":{"server.insecure":"true"}}'
kubectl rollout restart deployment argocd-server -n argocd

kubectl get secrets -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 --decode