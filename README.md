# aws-cloudshell
Install command-line utilities to build a test cluster

### Create an EKS cluster with AWS VPC CNI
```
eksctl create cluster --name dev-01 --version 1.23 --ssh-access --node-type t3.medium
```

### Create an EKS cluster with Calico CNI
```
eksctl create cluster --name dev-01  --version 1.23 --without-nodegroup
kubectl delete daemonset -n kube-system aws-node
kubectl apply -f https://docs.projectcalico.org/manifests/calico-vxlan.yaml
eksctl create nodegroup --cluster dev-01 --node-type t3.medium --node-ami auto --max-pods-per-node 100 --ssh-access
```

### Install Istio
```
istioctl install --set profile=demo
kubectl label namespace default istio-injection=enabled
```

### Install ArgoCD
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
argocd login [elb dns | ingress host]
```
default account admin / pass from secret above

### Install Argo Rollouts
```
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/stable/manifests/install.yaml
```

### Useful stuff
#### Get ENI count for machine type
```
aws ec2 describe-instance-types --filters Name=instance-type,Values=t3.* --query "InstanceTypes[].{Type: InstanceType, MaxENI: NetworkInfo.MaximumNetworkInterfaces, IPv4addr: NetworkInfo.Ipv4AddressesPerInterface}" --output table
```
#### Bitnami Sealed Secrets
```
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm repo update
helm install sealed-secrets-controller sealed-secrets/sealed-secrets
```
#### NGINX Ingress
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm show values ingress-nginx/ingress-nginx >ingress-nginx.yaml
# edit hostNetwork, HostPort, Daemonset
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace --values ingress-nginx.yaml
```
#### Ingress Resource for ArgoCD
Add `- --enable-ssl-passthrough` to ingress-nginx daemonset args
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd-server-ingress
  namespace: argocd
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
spec:
  rules:
  - host: server.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: argocd-server
            port:
              name: https
```
