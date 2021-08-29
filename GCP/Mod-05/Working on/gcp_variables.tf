
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