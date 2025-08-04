resource "yandex_vpc_network" "Diplom" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "master_subnet" {
  name           = var.master_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.Diplom.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "subnets" {
  count          = 3
  name           = "subnet-${var.subnets[count.index]}"
  zone           = "${var.subnets[count.index]}"
  network_id     = "${yandex_vpc_network.Diplom.id}"
  v4_cidr_blocks = [ "${var.cidrs[count.index]}" ]
}