resource "yandex_compute_disk" "boot-disk" {
  count    = var.vm_count
  name     = "boot-disk-${count.index}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = "20"
  image_id = "fd8a28k7fnc9u68s45g5"
}

resource "yandex_compute_instance" "default" {
  count       = var.vm_count
  name        = "debian-${count.index}"
  zone        = "ru-central1-a"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }
  # ubuntu-2404-lts-oslogin
  boot_disk {
    disk_id = yandex_compute_disk.boot-disk[count.index].id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "debian:${file(var.ssh_key_path)}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = yandex_vpc_network.network-1.id
}