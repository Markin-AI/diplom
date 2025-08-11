###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "Diplom"
  description = "VPC network"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "subnets" {
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
  description = "subnet zones (https://cloud.yandex.ru/docs/overview/concepts/geo-scope)"
}

variable "cidrs" {
  type        = list(string)
  default     = ["192.168.20.0/24", "192.168.30.0/24", "192.168.40.0/24"]
  description = "zone cirds (https://cloud.yandex.ru/docs/overview/concepts/geo-scope)"
}

variable "vms" {
  type = map(any)
  default = {
    cores         = 2,
    memory        = 2,
    core_fraction = 20,
    platform_id   = "standard-v3"
    image_family  = "ubuntu-2204-lts"
    image_id      = "fd8g2ntguckjq2boqjmh"
    disk_size     = 40
  }
}

variable "vms_master_name" {
  type        = string
  default     = "master"
  description = "Name for master"
}

variable "master_count" {
  type        = number
  default     = 1
  description = "Count for master"
}

variable "vms_worker_name" {
  type        = string
  default     = "worker"
  description = "Name for worker"
}

variable "worker_count" {
  type        = number
  default     = 3
  description = "Count for worker"
}

variable "user_name" {
  type = string
  default = "ubuntu"
}

variable "web_provision" {
  type        = bool
  default     = true
  description = "ansible provision switch variable"
}