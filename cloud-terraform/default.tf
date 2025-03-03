terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.122.0"
    }
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = var.key_path
}