helm repo add jetstack https://charts.jetstack.io --force-update
helm upgrade --install \
    cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --create-namespace \
    --version v1.18.2 \
    --set config.apiVersion="controller.config.cert-manager.io/v1alpha1" \
    --set config.kind="ControllerConfiguration" \
    --set config.enableGatewayAPI=true \
    --set crds.enabled=true
