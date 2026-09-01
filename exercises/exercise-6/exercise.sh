kubectl create deployment ben-coeppicus --image=harbor.container.it-scholar.com/seminar/ben-coeppicus:v4 --replicas=3

kubectl expose deployment ben-coeppicus --type=NodePort --port=8080

kubectl get pods -o wide
kubectl get svc ben-coeppicus
kubectl get nodes -o wide
kubectl describe svc ben-coeppicus