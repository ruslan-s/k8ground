# Argo CD CLI 
argocd login argocd.k8ground.test \
	--username xxx \
	--password xxx \
	--insecure \
	--grpc-web

argocd repo add https://github.com/ruslan-s/k8ground.git \
	--username <pat-secrtet> \
	--password <pat-secret> \
	--name k8ground \
	--project default

argocd app create root-app \
  --repo https://github.com/ruslan-s/k8ground.git \
  --path "argo-apps/app-of-apps" \
  --dest-namespace dg-argocd \
  --dest-server https://kubernetes.default.svc \
  --sync-policy automated \
  --auto-prune

# K8s CLI
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl create secret tls wildcard-k8ground-tls \
  --cert=wildcard.k8ground.test.crt \
  --key=wildcard.k8ground.test.key \
  -n kube-system  # Store in kube-system for cluster-wide use

# Others 
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout wildcard.k8ground.test.key -out wildcard.k8ground.test.crt \
  -subj "/CN=*.k8ground.test" \
  -addext "subjectAltName=DNS:*.k8ground.test,DNS:k8ground.test"


