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

variable "availability_domain" {
  
}

variable "instance_image_ocid" {
  type = map(string)

  default = {
    sa-saopaulo-1   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaudio63gdicxwujhfok7jdyewf6iwl6sgcaqlyk4fvttg3bw6gbpq"
  }
}

variable "ad_region_mapping" {
  type = map(string)

  default = {
    sa-saopaulo-1 = 1
  }
}

variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}