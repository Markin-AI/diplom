resource "helm_release" "ingress_nginx" {
    name = "my-nginx-ingress-controller"
    repository = "https://kubernetes.github.io/ingress-nginx"
    chart = "ingress-nginx"

    set = [ 
        {
      name = "controller.hostNetwork"
      value = "true"
    },
    {
        name = "controller.service.enabled"
        value = "false"
    }   
    ]
}
resource "helm_release" "prometheus_grafana" {
    name = "my-kube-prometheus-stack"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart = "kube-prometheus-stack"

}
resource "helm_release" "ingress" {
    name =  "ingress-grafana"
    chart = "./ingress"

    values = [file("./ingress/values.yaml")]
  
}