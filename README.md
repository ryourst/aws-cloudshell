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

### Useful stuff
Get ENI count for machine type
```
aws ec2 describe-instance-types --filters Name=instance-type,Values=t3.* --query "InstanceTypes[].{Type: InstanceType, MaxENI: NetworkInfo.MaximumNetworkInterfaces, IPv4addr: NetworkInfo.Ipv4AddressesPerInterface}" --output table
```
