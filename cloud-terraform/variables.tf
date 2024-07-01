variable "cloud_id" {
  description = "cloud_id"
  type        = string
}

variable "folder_id" {
  description = "folder_id"
  type        = string
}

variable "key_path" {
  description = "service account key_path"
  type        = string
}

variable "ssh_key_path" {
  description = "ssh_key_path"
  type        = string
}

variable "vm_count" {
  description = "Number of virtual machines to create"
  type        = number
  default     = 4
}
