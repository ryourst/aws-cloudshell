#! /bin/sh

[[ "${AWS_EXECUTION_ENV}" != "CloudShell" ]] && { echo "Please use AWS CloudShell."; exit 1; }

[[ ! -d "`echo ~`/.local/bin" ]] && mkdir -p "`echo ~`/.local/bin"
[[ ! -f "`echo ~`/.ssh/id_rsa" ]] && (echo "Generating new ssh-keypair." && ssh-keygen -b 2048 -t rsa -f "`echo ~`/.ssh/id_rsa" -q -N "")

echo Downloading lab assets.
# calicoctl -h &> /dev/null || (echo "Downloading calicoctl"; curl -Lo "`echo ~`/.local/bin/calicoctl" https://github.com/projectcalico/calicoctl/releases/download/v3.17.1/calicoctl-linux-amd64 )
kubectl -h &> /dev/null || (echo "Downloading kubectl"; curl -Lo "`echo ~`/.local/bin/kubectl" https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl )
eksctl -h &> /dev/null || (echo "Downloading eksctl"; curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp > /dev/null && mv /tmp/eksctl ~/.local/bin/eksctl )
istioctl -h &> /dev/null || (echo "Downloading istioctl"; cd ~ && curl --silent -L https://istio.io/downloadIstio | ISTIO_VERSION=1.15.1 TARGET_ARCH=x86_64 sh - > /dev/null && mv "`echo ~`"/istio-?.*.*/bin/istioctl ~/.local/bin/istioctl )
argocd -h &> /dev/null || (echo "Downloading argocd"; curl --silent -Lo "`echo ~`/.local/bin/argocd" https://github.com/argoproj/argo-cd/releases/download/v2.4.12/argocd-linux-amd64 )
chmod +x "`echo ~`/.local/bin/"*

echo Verifying installation.
# calicoctl -h &> /dev/null || { echo "Error downloading calicoctl. Please try again."; rm -f "`echo ~`/.local/bin/calicoctl"; exit 1; }
kubectl -h &> /dev/null || { echo "Error downloading kubectl. Please try again."; rm -f "`echo ~`/.local/bin/kubectl"; exit 1; }
eksctl -h &> /dev/null || { echo "Error downloading eksctl. Please try again."; rm -f "`echo ~`/.local/bin/eksctl"; exit 1; }
istioctl -h &> /dev/null || { echo "Error downloading istioctl. Please try again."; rm -f "`echo ~`/.local/bin/istioctl"; exit 1; }
argocd -h &> /dev/null || { echo "Error downloading argocd. Please try again."; rm -f "`echo ~`/.local/bin/argocd"; exit 1; }
echo Installation complete.

exit 0

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.15.1 TARGET_ARCH=x86_64 sh -
