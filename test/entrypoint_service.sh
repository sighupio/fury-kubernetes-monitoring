#!/bin/sh
NAME=$(date +%s)
build () {
  for i in $(seq 3)
  do
    if ! kind create cluster --loglevel debug --name "$NAME" --config test/kind-config ;
    then
      kind delete cluster --name="$NAME"
    else
      export KUBECONFIG="$(kind get kubeconfig-path --name="$NAME")"
      sed -i 's/localhost/'"$CLUSTER_HOST"'/g' "$KUBECONFIG"
      while ! kubectl get nodes ; do echo "no nodes still" && sleep 1; done
      cat "$KUBECONFIG"
      cp "$KUBECONFIG" "$DEST"
      break
    fi
  done
}
build &
child=$!
cleanup() {
  echo "deleting cluster $NAME"
  kind delete cluster --name="$NAME"
  kill $child
}

trap cleanup SIGTERM
while true
do
  sleep 60 &
  wait $!
done
