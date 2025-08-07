resource "yandex_vpc_network" "Diplom" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnets" {
  count          = 3
  name           = "subnet-${var.subnets[count.index]}"
  zone           = "${var.subnets[count.index]}"
  network_id     = "${yandex_vpc_network.Diplom.id}"
  v4_cidr_blocks = [ "${var.cidrs[count.index]}" ]
}