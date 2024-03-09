#!/bin/bash

if [[ ! $(which kubectl) ]]; then
    echo -e "Kubectl is not installed, installing Kubectl...\n"
    arch=$(arch)
    case "$(uname -sr)" in

        Darwin*)
            echo -e "\n\n######### Mac OS X is detected in the Host, installing Kubectl"
            brew install kubectl
        ;;

        Linux*)
            echo -e "\n\n######### Linux OS is detected in the Host, installing Kubectl"
            if [ $arch=="x86_64" ]; then
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
            elif [ $arch=="arm64" ]; then
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
            fi
            sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        ;;

        CYGWIN*|MINGW*|MINGW32*|MSYS*)
            echo -e "\n\n######### MS Windows OS is detected in the Host, installing Kubectl"
            curl.exe -LO "https://dl.k8s.io/release/v1.29.2/bin/windows/amd64/kubectl.exe"
            mv kubectl.exe ~/AppData/Local/Microsoft/WindowsApps/
        ;;

        *)
            echo -e "\n\n######### Could not find any matching OS. Please install Kubectl https://kubernetes.io/docs/tasks/tools/#kubectl"
        ;;
    esac
else
    echo -e "\n\nKubectl is already installed."
fi

if [ -f ~/.kube/config ]; then
    bak_config_file="config.bak-$(date +"%Y-%m-%d-%H-%M-%S")"
    echo -e "\nKubectl config file exist in ~/.kube/ directory. Creating backup file '${bak_config_file}' for exiting config file into ~/.kube/ directory"
    cp ~/.kube/config ~/.kube/${bak_config_file}
fi
if [ -f ../kube-config ]; then
    echo -e "\nUpdating Kubectl config file for your K3s cluster..."
    mkdir -p ~/.kube
    cp ../kube-config ~/.kube/config
    echo -e "\n\n######### Your K3s cluster is ready. Use 'kubectl' commands to deploy your application\n"
    kubectl get nodes
else
    echo -e "\n\n######### K3s cluster wan't creaed properly. Destroy the VMs and recreated using 'bash k3s up'"
fi
