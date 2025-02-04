#!/usr/bin
echo "Starting argocd setup"

ARGOCDVERSION="v2.7.2"
ARGOCDGIT="https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCDVERSION}/manifests/install.yaml"

CURRDIR=$(pwd)

GITUSER=${USERNAME}
GITPASSWORD=${GITPASSWD}
GITREPO="https://github.com/SrikarManthatti/myargolocalapps.git"

kubectl apply -f ${CURRDIR}/namespaces/

echo "getting install.yaml from ${ARGOCDGIT}"

curl -o ${CURRDIR}/install.yaml ${ARGOCDGIT}

kubectl apply -f install.yaml -n argocd


