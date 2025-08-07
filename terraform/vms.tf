resource "yandex_compute_instance" "master" {
  count                     = var.master_count
  name                      = "${var.vms_master_name}-${count.index+1}"
  zone                      = "${var.subnets[count.index]}"
  platform_id               = var.vms.platform_id
  hostname                  = "${var.vms_master_name}-${count.index+1}"
  allow_stopping_for_update = true

  resources {
    cores                   = var.vms.cores
    memory                  = var.vms.memory
    core_fraction           = var.vms.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id              = var.vms.image_id
      size                  = var.vms.disk_size
    }
  }

  scheduling_policy {
    preemptible             = true
  }


  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnets[count.index].id}"
    nat       = true
  }
  metadata = local.ssh_keys_and_serial_port

}

resource "yandex_compute_instance" "worker" {
  count                     = var.worker_count
  name                      = "${var.vms_worker_name}-${count.index+1}"
  zone                      = "${var.subnets[count.index]}"
  platform_id               = var.vms.platform_id
  hostname                  = "${var.vms_worker_name}-${count.index+1}"
  allow_stopping_for_update = true

  resources {
    cores         = var.vms.cores
    memory        = var.vms.memory
    core_fraction = var.vms.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.vms.image_id
      size     = var.vms.disk_size
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnets[count.index].id}"
    nat       = true
  }
  metadata = local.ssh_keys_and_serial_port
}