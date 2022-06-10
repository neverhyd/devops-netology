provider "yandex" {
  cloud_id                 = "b1g6o9nbqprifm39mhjb"
  folder_id                = "b1ga2tn38illd1pka3h3"
  zone                     = "ru-central1-a"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm-test1" {
  name = "test1"

  resources {
    cores  = 1
    memory = 1
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }
}

resource "yandex_vpc_network" "default" {
  name = "net"
}
resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "enpqafnl8dbg1ese3en5"
  v4_cidr_blocks = ["192.168.101.0/24"]
}
