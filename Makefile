include .env

.PHONY: create
create:
	kind create cluster --kubeconfig ~/.kube/config

.PHONY: install
install:
	helm repo add renovate https://docs.renovatebot.com/helm-charts
	helm repo update
	helm install renovate --kube-context kind-kind --set env.RENOVATE_TOKEN=${RENOVATE_TOKEN} --values values.yaml renovate/renovate

.PHONY: uninstall
uninstall:
	helm uninstall --kube-context kind-kind renovate

.PHONEY: upgrade
upgrade: uninstall install
