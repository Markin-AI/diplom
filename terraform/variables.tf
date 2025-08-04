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

variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
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

variable "master_subnet" {
  type        = string
  default     = "master_subnet"
  description = "Subnet name for master"
}