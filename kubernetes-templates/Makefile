DOCKER_IMAGE=dgur1n/xap:12.1.0
DOCKER_USER=dgur1n
DOCKER_PASSWORD=<PASSWORD>
DOCKER_EMAIL=<EMAIL>

IMAGE_REPO_SECRET=xap12-private-docker-repo

XAP_LICENSE_KEY="<XAP-LICENSE>"

XAP_LUS_OPTIONS=""
XAP_GSC_OPTIONS=""
XAP_GSM_OPTIONS=""

create-image-repo-secret:
	-kubectl create secret docker-registry $(IMAGE_REPO_SECRET) --docker-username=$(DOCKER_USER) --docker-password=$(DOCKER_PASSWORD) --docker-email=$(DOCKER_EMAIL)
start-xap-datagrid:
	@echo -e '\n-- Creating XAP license secret'
	@-kubectl create secret generic xap-license-secret --from-literal=xap-license=$(XAP_LICENSE_KEY)

	@echo -e '\n-- Creating XAP configuration maps'
	@-kubectl delete configmap xap-config-map
	@echo 'New configmap:'
	@-kubectl create configmap xap-config-map \
		--from-literal=xap-gsc-options=$(XAP_GSC_OPTIONS) \
		--from-literal=xap-gsm-options=$(XAP_GSM_OPTIONS) \
		--from-literal=xap-lus-options=$(XAP_LUS_OPTIONS) --output=yaml

	@echo -e '\n-- Creating service for xap nodes'
	@kubectl create -f xap-node-svc.yaml

	@echo -e '\n-- Creating deployment for xap-node'
	@sed -e 's|<image>|$(DOCKER_IMAGE)|g' -e 's|<imagePullSecret>|$(IMAGE_REPO_SECRET)|g' xap-node.yaml | kubectl create -f -

	@echo -e '\n-- Creating GS Webui Service'
	@kubectl create -f gs-webui-svc.yaml

	@echo -e '\n-- Creating GS Webui Deployment'
	@sed -e 's|<image>|$(DOCKER_IMAGE)|g' -e 's|<imagePullSecret>|$(IMAGE_REPO_SECRET)|g' gs-webui.yaml | kubectl create -f -

	@echo ''
stop-xap-datagrid:
	-kubectl delete services gs-webui
	-kubectl delete services xap-node
	-kubectl delete --all deployments
	-kubectl delete --all pods
cleanup:
	-kubectl delete secret xap-license-secret
	-kubectl delete secret xap12-private-docker-repo
	-kubectl delete configmap xap-config-map
