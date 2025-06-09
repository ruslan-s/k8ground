helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd \
  -n dg-argocd \
  --create-namespace \
  --values argocd-values.yaml

# kubectl apply -f ingress.yaml

# helm uninstall argocd -n dg-argocd

# In order to access the server UI you have the following options:

# 1. kubectl port-forward service/argocd-server -n devground 8080:443

#     and then open the browser on http://localhost:8080 and accept the certificate

# 2. enable ingress in the values file `server.ingress.enabled` and either
#       - Add the annotation for ssl passthrough: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-1-ssl-passthrough
#       - Set the `configs.params."server.insecure"` in the values file and terminate SSL at your ingress: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-2-multiple-ingress-objects-and-hosts


# After reaching the UI the first time you can login with username: admin and the random password generated during the installation. You can find the password by running:

# kubectl -n devground get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# (You should delete the initial secret afterwards as suggested by the Getting Started Guide: https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)