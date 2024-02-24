## Create Local Kubernetes Cluster using K3s
K3s is a lightweight Kubernetes distribution created by Rancher Labs, and it is fully certified by the `Cloud Native Computing Foundation` (CNCF). K3s is highly available and production-ready. It has a very small binary size and very low resource requirements.

### How to
- This repository uses Virtual Machines powered by Vagrant & a Hypervisor of your choice such as VirtualBox, VMware Workstation or VMware Fusion. You will `Vagrantfile` for each hypervisor inside the folder named by hypervisor. By default, the `Vagrantfile` creates two VMs: one for master/control-plane node and another for worker node. You can add more worker nodes in the `k3s_cluster` map in `Vagrantfile`

- Go to folder, modify the `Vagrantfile` to update IP addresses of the VMs (master & worker nodes) with the IP address of your Hypervisor's Network adapter and save it

- Once done, use `vagrant up` command to create the VMs and configure the K3s into them

- SSH into the master node using `vagrant ssh k3s-server` and use `sudo kubectl get nodes` to view the nodes. And your local Kubernetes cluster is ready to use
