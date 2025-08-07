output "cluster-k8s-master" {
    value = [
    for i in yandex_compute_instance.master: 
   "name = ${i.name} | external-ip=${i.network_interface.0.ip_address} | internal-ip=${i.network_interface.0.nat_ip_address}"
  ]
}

output "cluster-k8s-workers" {
  value = [
    for i in yandex_compute_instance.worker: 
   "name = ${i.name} | external-ip=${i.network_interface.0.ip_address} | internal-ip=${i.network_interface.0.nat_ip_address}"
  ]
}