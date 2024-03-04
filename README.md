## Create Local Kubernetes Cluster using K3s
K3s is a lightweight Kubernetes distribution created by Rancher Labs, and it is fully certified by the `Cloud Native Computing Foundation` (CNCF). K3s is highly available and production-ready. It has a very small binary size and very low resource requirements.

### How to
- This repository uses Virtual Machines powered by Vagrant & a Hypervisor of your choice such as VirtualBox, VMware Workstation or VMware Fusion. You will `Vagrantfile` for each hypervisor inside the folder named by hypervisor. By default, the `Vagrantfile` creates two VMs: one for master/control-plane node and another for worker node. You can add more worker nodes in the `k3s_cluster` map in `Vagrantfile`

- Clone this repository. Do not change the name (`local-k3s`) of repository directory, as the directory name is used to sync this folder inside the VM. Changing the directory requires to update the name in `config.vm.synced_folder` config section in the `Vagrantfile`

- Go to folder, modify the `Vagrantfile` to update IP addresses of the VMs (master & worker nodes) with the IP address of your Hypervisor's Network adapter and save it. (in a terminal, use `ipconfig` or `ip address` or `ifconfig` depending on your OS to find your Hypervisor's Network adapter IP range)

- Once done, use `bash k3s up` command to create the VMs and configure the K3s into them

- You can use either `vagrant` or `bash k3s` command to operate on the VMS, likewise:
```
bash k3s up
bash k3s status
bash k3s reload
bash k3s reload --provision
bash k3s provision
bash k3s destroy
bash k3s halt
bash k3s ssh k3s-server
```

- On your laptop, use `kubectl get nodes` to view the nodes. And your local Kubernetes cluster is ready to use

- If you want to add more worker nodes, just update the `Vagrantfile` and use `bash k3s up` command to create and configure new worker node

- If you want to update the CPU/Memory to any nodes, just update the `Vagrantfile` and use `bash k3s reload --provision`

### Manual Installation
- On Master node (you need IP address of master node):
```
server_ip=
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--tls-san=${server_ip} --node-ip=${server_ip}" sh -
```

- Get token from Master node to join Worker: `sudo cat /var/lib/rancher/k3s/server/node-token`

- On Worker nodes (you need IP address of Master and Worker node and token):
```
server_ip=
node_ip=
token=

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent" sh -s - --server https://${server_ip}:6443 --token $token --node-ip ${node_ip}
```

- SSH to Master node, `vagrant ssh k3s-server` and use `kubectl` command to use the cluster

- The kubectl config file is stored in Master node at `/etc/rancher/k3s/k3s.yaml`. If you want to access the cluster from your laptop/host:
  - Install kubectl - https://kubernetes.io/docs/tasks/tools/#kubectl
  - Create a file `~/.kube/config`, copy the content from `/etc/rancher/k3s/k3s.yaml` and replace `127.0.0.1` with the Master node IP address
  - Use `kubectl get nodes` to verify
