# Let's put kubectl config in the config folder
KUBEFOLDER=~/.config/kube
export KUBECONFIG=$KUBEFOLDER/config
# Load contexts from individual files
function set-kubeconfig {
  # Does NOT overwrite KUBECONFIG if the KUBECONFIG_MANUAL env var is set
  if [ -d $KUBEFOLDER/contexts ]; then
    if [ -z "$KUBECONFIG_MANUAL" ]; then
      export KUBECONFIG=$KUBEFOLDER/config$(find $KUBEFOLDER/contexts -type f 2>/dev/null | xargs -I % echo -n ":%")
    fi
  fi
}

set-kubeconfig
