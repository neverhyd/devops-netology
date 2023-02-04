resource "yandex_compute_instance_group" "ig-1" {
  name               = "fixed-ig"
  folder_id          = var.yc_folder_id
  service_account_id = var.yc_sa_id
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp_id
      }
    }

    network_interface {
      network_id = yandex_vpc_network.netology.id
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
    }

    metadata = {
      ssh-keys  = "user:${file("~/.ssh/id_rsa.pub")}"
      user-data = file("${path.module}/cloud-config.yaml")
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }
  load_balancer {
    target_group_name        = "ig-1"
    target_group_description = "load balancer target group"
  }
}

resource "yandex_vpc_network" "netology" {
  name = "netology"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
