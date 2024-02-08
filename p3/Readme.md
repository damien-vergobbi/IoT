# Script SH
File 'hosts.sh' in conf/ folder is used to set hosts in /etc/hosts/ master VM.

# K3D
    - sudo kubectl get namespaces : liste des namespace
    - sudo k3d cluster create [NAME] : creer un nouveau cluster
    - export KUBECONFIG="$(k3d get-kubeconfig --name='NAME')" : kubectl and k3s

# Argo CD
    - sudo kubectl get pods -n argocd : voir si les pods sont bien build et run
    - sudo lsof -i -P -n | grep LISTEN
    - sudo netstat -tulpn | grep 6443
    - https://localhost:8085/

# Delete
    - k3d cluster delete part3
    - kubectl delete namespace argocd
    
# Utils
    - sudo kubectl get pods -n dev
    - kubectl describe pod <nom-du-pod> -n dev
    - kubectl delete pod -n dev -l app=wil : restart pod
    - sudo kubectl exec -it <nom-du-pod> -n dev -- sh
    