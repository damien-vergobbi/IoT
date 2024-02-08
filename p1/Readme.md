# Host
    - vagrant up : monter les images
    - vagrant destroy -f : supprimer les images
    - vagrant halt : stopper l'image
    - vagrant suspend : forcer l'arret

# Vagrant's VM
    - kubectl get nodes -o wide : retourne les pods K3S
    - ifconfig eth1 : doit retourner l'ip demandee dans le sujet