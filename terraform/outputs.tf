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

output "Grafana_Network_Load_Balancer_Address" {
  value = yandex_lb_network_load_balancer.monapp.listener.*.external_address_spec[0].*.address
  description = "Адрес сетевого балансировщика для Grafana и Тестового приложения"
}

output "Web_App_Network_Load_Balancer_Address" {
  value = yandex_lb_network_load_balancer.atlantis.listener.*.external_address_spec[0].*.address
  description = "Адрес сетевого балансировщика Atlantis"
}