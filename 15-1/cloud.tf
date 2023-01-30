terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
  token = var.yc_token
  cloud_id = var.yc_cloud_id
  folder_id = var.yc_folder_id
}

resource "yandex_vpc_network" "netology" {
  name = "netology"
}

resource "yandex_vpc_subnet" "public" {
  name = "public"
  v4_cidr_blocks = var.puclic_net
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology.id
}

resource "yandex_vpc_route_table" "defroute" {
  name = "private_default_gw"
  network_id = yandex_vpc_network.netology.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = var.def_router_ip
  }
}


resource "yandex_vpc_subnet" "private" {
  v4_cidr_blocks = var.private_net
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology.id
  route_table_id = yandex_vpc_route_table.defroute.id
}

resource "yandex_compute_instance" "test-nat" {
  name        = "test-nat"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_instance_id
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    ip_address = var.def_router_ip
    nat        = true
  }
  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "pc-public" {
  name        = "pc-public"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.debian_id
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    ip_address = "192.168.10.100"
    nat        = true
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "pc-private" {
  name        = "pc-private"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.debian_id
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.private.id
    ip_address = "192.168.20.100"
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
