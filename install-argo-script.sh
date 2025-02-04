#!/usr/bin
echo "Starting argocd setup"

ARGOCDVERSION="v2.7.2"
ARGOCDGIT="https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCDVERSION}/manifests/install.yaml"

CURRDIR=$(pwd)

GITUSER=${USERNAME}
GITPASSWORD=${GITPASSWD}
GITREPO="https://github.com/SrikarManthatti/"

kubectl apply -f ${CURRDIR}/namespaces/

echo "getting install.yaml from ${ARGOCDGIT}"

if [ -f "install.yaml" ] && grep -q "${ARGOCDVERSION}" install.yaml; then
    echo "already present"
else
    curl -o ${CURRDIR}/install.yaml ${ARGOCDGIT}

    kubectl apply -f install.yaml -n argocd
fi 

cat initial_repo.yaml | sed "s|REPLACEPRIVATEREPO|${GITREPO}|g" | sed "s|REPLACEUSERNAME|${GITUSER}|g" | sed "s|REPLACEPASSWORD|${GITPASSWORD}|g" | kubectl apply -f -

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > temp_password.txt



