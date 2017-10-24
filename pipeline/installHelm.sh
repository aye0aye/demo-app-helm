#! /bin/bash -e

# install Helm CLI 
install_HelmCli() {
  echo -n "installing Helm CLI..."

  # install Helm
  curl -q https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
  chmod 700 get_helm.sh
  ./get_helm.sh

  # initialize Helm (must follow kubectl installation)
  helm init

  if [[ ! $(which helm) ]]; then
    if [[ $(aws help) ]]; then
      echo "Helm CLI installed successfully"
    fi
  fi

  # wait for tiller pod to be available
  while [ $(kubectl -n kube-system get pods | grep "tiller" | awk '{print $3}') != "Running" ]
  do
    echo "Tiller pod not yet active"
    sleep 10
  done
  echo "Tiller pod now active"
}

install_HelmCli
