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
kubectl get deployments --namespace=<namespace-name>
kubectl get pods --namespace=<namespace-name>
kubectl expose deployment <deployment-name> --name=<service-name> --port=80 --target-port=80 --namespace=<namespace-name> --type=LoadBalancer
kubectl get services --namespace=<namespace-name>
kubectl delete service <service-name> --namespace=<namespace-name>
kubectl delete deployment <deployment-name> --namespace=<namespace-name>
# Force delete a Service
kubectl delete service <service-name> --namespace=<namespace-name> --force --grace-period=0
# Force delete a Deployment
kubectl delete deployment <deployment-name> --namespace=<namespace-name> --force --grace-period=0