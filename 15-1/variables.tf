variable "yc_token" {
  type = string
  description = "Yandex Cloud OAuth token"
}
variable "yc_cloud_id" {
  type = string
  description = "Yandex Cloud ID"
  default = ""
}
variable "yc_folder_id" {
  type = string
  description = "Yandex Cloud Folder ID"
  default = ""
}
variable "puclic_net" {
 default = ["192.168.10.0/24"]
}
variable "private_net" {
 default = ["192.168.20.0/24"]
}
variable "nat_instance_id" {
 default = "fd8o8aph4t4pdisf1fio"
}
variable "debian_id" {
 default = "fd8a67rb91j689dqp60h"
}
variable "def_router_ip" {
 default = "192.168.10.254"
}
