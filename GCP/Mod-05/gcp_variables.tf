variable "gcp_credentials_file_path" {
  type        = string
}

variable "gcp_project_id" {
  type        = string
}

variable "gcp_instance_type" {
  default     = "e2-micro"
}

variable "gcp_disk_image" {
  default     = "projects/debian-cloud/global/images/family/debian-11"
}

variable "gcp_region" {
  default     = "us-west1"
}

variable "gcp_zone" {
  default = "us-west1-b"
}

variable "gcp_network_cidr" {
  default = "10.88.0.0/16"
}

variable "gcp_subnet1_cidr" {
  default = "10.88.0.0/24"
}

variable "gcp_vm_address_eua-app01" {
  default     = "10.88.0.100"
}

variable "gcp_vm_address_eua-db01" {
  default     = "10.88.0.101"
}



