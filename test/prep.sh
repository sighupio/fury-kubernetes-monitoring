NAME=$(date +%s)
build () {
  for i in $(seq 3)
  do
    if ! kind create cluster --loglevel debug --name "$NAME" --config test/kind-config ;
    then
      kind delete cluster --name="$NAME"
      sleep 5
    else
      export KUBECONFIG="$(kind get kubeconfig-path --name="$NAME")"
      sed -i 's/localhost/'"$CLUSTER_HOST"'/g' "$KUBECONFIG"
      while ! kubectl get nodes ; do echo "no nodes still" && sleep 1; done
      cat "$KUBECONFIG"
      return 0
    fi
  done
  return 1
}
cleanup() {
  echo "deleting cluster $NAME"
  kind delete cluster --name="$NAME"
}

sleep 5
if build ;
then
  export KUBECONFIG="$(kind get kubeconfig-path --name="$NAME")"
  for el in "$@"; do
    for try in `seq 1 3`; do
      echo "applying $el, $try time"
      kustomize build $el | kubectl apply -f - && e=0 && break || e=$? && sleep 4 ;
    done
    [ $e -gt 0 ] && echo "error with $el" && cleanup && return $e
  done
else
  cleanup
  return 1
fi
cleanup
