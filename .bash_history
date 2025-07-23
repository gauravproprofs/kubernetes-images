apt update
hostnamectl
hostnamectl set-hostname k8-server
vim /etc/hosts
hostnamectl set-hostname k8-master
hostname
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
free -m
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system
apt install -y docker.io
systemctl enable docker
systemctl start docker
systemctl status docker
docker --version
containerd config default | sudo tee /etc/containerd/config.toml
systemctl restart containerd
mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
kubeadm init --pod-network-cidr=10.244.0.0/16
sudo modprobe br_netfilter
echo "br_netfilter" | sudo tee /etc/modules-load.d/k8s.conf
sudo tee /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system
lsmod | grep br_netfilter
cat /proc/sys/net/bridge/bridge-nf-call-iptables
kubeadm init --pod-network-cidr=10.244.0.0/16
vim /etc/hosts
ctr version
vim etc/containerd/config.toml
systemctl daemon-reexec
sudo containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
vim etc/containerd/config.toml
crictl info | grep SystemdCgroup
vim /etc/crictl.yaml
vim etc/containerd/config.toml
which containerd
containerd config default
sudo containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
vim /etc/containerd/config.toml
systemctl restart containerd
kubectl get nodes
export KUBECONFIG=/etc/kubernetes/admin.conf
vim .bashrc
echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> ~/.bashrc
source ~/.bashrc
kubectl get nodes
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
kubectl get nodes
kubectl get po -o yaml
kubectl get nodes
kubectl get po -o wide
vim apache-nginx-pod.yaml
kubectl apply -f apache-nginx-pod.yaml
kubectl get pods
kubectl describe pod apache-nginx
kubectl get pods
kubectl delete pod apache-nginx
kubectl get pods
vim  apache-nginx-pod.yaml 
kubectl apply -f apache-nginx-pod.yaml
kubectl get pods
kubectl exec -it apache-nginx --/bin/bash
kubectl exec -it apache-nginx /bin/bash
kubectl get pods
kubectl get pods -n kube-system -l k8s-app=kube-dns
vim /etc/resolv.conf 
kubectl exec -it apache-nginx /bin/bash
vim /etc/resolv.conf 
kubectl exec -it apache-nginx /bin/bash
vim Dockerfile_app012
docker build -t baseimage:2.0 -f Dockerfile_app012 
docker build -t baseimage:2.0 -f Dockerfile_app012 .
docker images
vim kube-compose-app012.yml
kubectl apply -f kube-compose-app012.yml
kubectl get pods
kubectl describe pod app012-example-com
docker images
vim kube-compose-app012.yml
kubectl get pods
kubectl delete pod app012-example-com
vim kube-compose-app012.yml
kubectl apply -f kube-compose-app012.yml
kubectl get pods
kubectl describe pod app012-example-com
vim kube-compose-app012.yml
kubectl get pods
kubectl delete pod app012-example-com
kubectl apply -f kube-compose-app012.yml
kubectl get pods
kubectl describe pod app012-example-com
kubectl get pods
kubectl delete pod app012-example-com
kubectl get pods
kubectl apply -f kube-compose-app012.yml Dockerfile_app012 
