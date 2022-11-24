GH_USER="openshift"
OCM_CONTAINER_PATH="${HOME}/Projects/github.com/${GH_USER}/ocm-container"

alias ocm-container="${OCM_CONTAINER_PATH}/ocm-container.sh"
alias ocm-container-stg="OCM_URL=staging ${OCM_CONTAINER_PATH}/ocm-container.sh"
alias ocm-container-int="OCM_URL=integration ${OCM_CONTAINER_PATH}/ocm-container.sh"
alias ocm-container-build="cd ${OCM_CONTAINER_PATH} && ./build.sh"
