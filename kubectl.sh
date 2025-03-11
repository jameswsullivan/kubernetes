# Count number of pods:
kubectl get pods --all-namespaces -o jsonpath='{.items[*].spec.containers[*].name}' | wc -w
kubectl get pods --all-namespaces -o jsonpath="{range .items[*]}{range .status.containerStatuses[?(@.state.running)]}{.name}{'\n'}{end}{end}" | wc -l

# List pods:
kubectl get pods
kubectl get pods --namespace <namespace-name>
kubectl get pods --namespace <namespace-name> -o jsonpath="{.items[*].metadata.name}"
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces -o wide
kubectl get pods --all-namespaces -o=custom-columns=NAME:.metadata.name,NODE:.spec.nodeName
kubectl get pods --all-namespaces -o jsonpath="{.items[*].metadata.name}"
kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].name}"
kubectl get pods --all-namespaces -o jsonpath="{.items[*].metadata.name}" | wc -w

# List namespaces:
kubectl get namespaces
kubectl get namespaces --output=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.annotations.field\.cattle\.io/projectId}{"\n"}{end}'
kubectl get namespaces --selector=field.cattle.io/projectId=<project-id> --output=jsonpath='{.items[*].metadata.name}{"\n"}'

# List running containers:
kubectl get pods --all-namespaces -o jsonpath="{range .items[*]}{.metadata.name}:{' '}{range .status.containerStatuses[?(@.state.running)]}{' '}{end}{'\n'}{end}" | wc -l
kubectl get pods --all-namespaces -o jsonpath="{range .items[*]}{.metadata.name}:{' '}{range .status.containerStatuses[?(@.state.running)]}{' '}{end}{'\n'}{end}" | wc -w

# Create/delete namespace, deploy, restart/delete pods:
kubectl create namespace <namespace-name>
kubectl annotate namespace mynamespace field.cattle.io/projectId=<project-id-in-Rancher>
kubectl annotate namespace mynamespace field.cattle.io/creatorId=<user-id-in-Rancher>
kubectl run <pod-name> --image=ubuntu:latest --namespace=<namespace-name> --command -- /bin/sh -c "tail -f /dev/null"
kubectl delete pod <pod-name> -n <namespace-name>
kubectl delete namespace <namespace-name>

# Get annotations:
kubectl get namespace <namespace-name> -o jsonpath='{.metadata.annotations}' --namespace=<namespace-name>

for ns in $(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}'); do
  annotations=$(kubectl get namespace $ns -o jsonpath='{.metadata.annotations}' --namespace=$ns)
  echo "Annotations for namespace $ns:"
  echo "$annotations"
done

# Deployment:
kubectl create deployment <deployment-name> --image=<image> --replicas=2 --namespace=<namespace-name>
kubectl scale deployment/<deployment-name> --replicas=3 --namespace=<namespace-name>
kubectl get deployments --namespace <namespace>
kubectl get secrets --namespace <namespace>
kubectl get pods --namespace=<namespace-name>
kubectl expose deployment <deployment-name> --name=<service-name> --port=80 --target-port=80 --namespace=<namespace-name> --type=LoadBalancer
kubectl get services --namespace=<namespace-name>
kubectl delete service <service-name> --namespace=<namespace-name>
kubectl delete deployment <deployment-name> --namespace=<namespace-name>
# Force delete a Service
kubectl delete service <service-name> --namespace=<namespace-name> --force --grace-period=0
# Force delete a Deployment
kubectl delete deployment <deployment-name> --namespace=<namespace-name> --force --grace-period=0
kubectl delete pod <pod-name> --namespace <namespace>
# Restart deployment and check deployment status
kubectl rollout restart deployment <deployment-name> --namespace <namespace>
kubectl rollout status deployment <deployment-name> --namespace <namespace>
# Change deployment's image
kubectl set image deployment <deployment-name> <deployment-name>=<image-tag> -n <namespace>


# Check the Kubernetes Context
kubectl config current-context
kubectl config get-contexts
kubectl config use-context <context-name>
kubectl cluster-info

# Kubernetes service account
kubectl get serviceaccount <serviceaccount-name> --namespace <namespace>
kubectl describe serviceaccount <serviceaccount-name> --namespace <namespace>
kubectl create serviceaccount <serviceaccount-name> --namespace <namespace>
kubectl delete serviceaccount <serviceaccount-name> --namespace <namespace>

# Role
kubectl get role <role-name> --namespace <namespace>
kubectl describe role <role-name> --namespace <namespace>
kubectl get clusterrole <clusterrole-name>
kubectl describe clusterrole <clusterrole-name>
kubectl create role <role-name> --verb=get,list,watch,update,patch --resource=deployments,pods --namespace <namespace>
kubectl edit role <role-name> --namespace <namespace>
kubectl delete role <role-name> --namespace <namespace>
kubectl delete clusterrole <clusterrole-name>

# RoleBinding
kubectl get rolebinding <rolebinding-name> --namespace <namespace>
kubectl describe rolebinding <rolebinding-name> --namespace <namespace>
kubectl get clusterrolebinding <clusterrolebinding-name>
kubectl describe clusterrolebinding <clusterrolebinding-name>
kubectl create rolebinding <rolebinding-name> --role=<role-name> --serviceaccount=<namespace>:<serviceaccount-name> --namespace <namespace>
kubectl create clusterrole <clusterrole-name> --verb=get,list,watch,update,patch --resource=deployments,pods
kubectl create clusterrolebinding <clusterrolebinding-name> --clusterrole=<clusterrole-name> --serviceaccount=<namespace>:<serviceaccount-name>
kubectl delete rolebinding <rolebinding-name> --namespace <namespace>
kubectl delete clusterrolebinding <clusterrolebinding-name>

