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

resource "yandex_lb_target_group" "balancer-group" {
  name       = "balancer-group"
  depends_on = [yandex_compute_instance.master]
  dynamic "target" {
    for_each = yandex_compute_instance.worker
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "monapp" {
  name = "monapp"
  listener {
    name        = "monapp-listener"
    port        = 80
    target_port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.balancer-group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 80
      }
    }
  }
  depends_on = [yandex_lb_target_group.balancer-group]
}

resource "yandex_lb_network_load_balancer" "atlantis" {
  name = "atlantis"
  listener {
    name        = "atlantis-listener"
    port        = 80
    target_port = 30080
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.balancer-group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = 30080
      }
    }
  }
  depends_on = [yandex_lb_network_load_balancer.monapp]
}