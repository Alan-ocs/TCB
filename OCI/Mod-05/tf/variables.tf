variable "tenancy_ocid" {
}

variable "compartment_ocid" { 
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key" {
}

variable "region" {
}

variable "ssh_public_key_file" { 
}

variable "ssh_private_key_file" { 
}

variable "availability_domain" {
}

variable "instance_image_ocid" {
  type = map(string)

  default = {
    sa-saopaulo-1   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaudio63gdicxwujhfok7jdyewf6iwl6sgcaqlyk4fvttg3bw6gbpq"
  }
}


variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}


variable "ad_region_mapping" {
  type = map(string)

  default = {
    us-phoenix-1 = 1
    us-ashburn-1 = 2
    sa-saopaulo-1 = 1
  }
}

variable "images" {
  type = map(string)

  default = {
    sa-saopaulo-1   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaudio63gdicxwujhfok7jdyewf6iwl6sgcaqlyk4fvttg3bw6gbpq"
  }
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = var.ad_region_mapping[var.region]
}