// Copyright (c) 2017, 2021, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0


variable "compartment_ocid" {}
variable "region" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

variable "machine_amount" {
  default = 0
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key = var.private_key
  region = var.region
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

resource "oci_core_virtual_network" "tcb_vcn" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "tcbVCN"
  dns_label      = "tcbvcn"
}

resource "oci_core_subnet" "tcb_subnet" {
  cidr_block        = "10.1.20.0/24"
  display_name      = "tcbSubnet"
  dns_label         = "tcbsubnet"
  security_list_ids = [oci_core_security_list.tcb_security_list.id]
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.tcb_vcn.id
  route_table_id    = oci_core_route_table.tcb_route_table.id
  dhcp_options_id   = oci_core_virtual_network.tcb_vcn.default_dhcp_options_id
}

resource "oci_core_internet_gateway" "tcb_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "tcbIG"
  vcn_id         = oci_core_virtual_network.tcb_vcn.id
}

resource "oci_core_route_table" "tcb_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.tcb_vcn.id
  display_name   = "tcbRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.tcb_internet_gateway.id
  }
}

resource "oci_core_security_list" "tcb_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.tcb_vcn.id
  display_name   = "tcbSecurityList"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
}

resource "oci_core_instance" "webserver1" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  count               = var.machine_amount
  display_name        = "webserver0${count.index +1}"
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = oci_core_subnet.tcb_subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "webserver0${count.index +1}"
  }

  source_details {
    source_type = "image"
    source_id   = var.images[var.region]
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "remote-exec" {
      inline = ["wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/_taLFTuy_AYrS2PloNwMKVGI-pXqJLjeOC_iXNrutee9xXYuOYMBcqlK8SQO_QuH/n/idqfa2z2mift/b/bootcamp-oci/o/deploy_niture.sh",
                "chmod +x deploy_niture.sh",
                "./deploy_niture.sh",
                "echo Done!"]

      connection {
        host = self.public_ip
        type = "ssh"
        user = "opc"
        private_key = var.ssh_private_key
      }
  }              

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }  
}

resource "oci_core_network_security_group" "nsg_tcb" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_virtual_network.tcb_vcn.id
  display_name = "net_sg_tcb"
}

resource "oci_load_balancer" "test_load_balancer" {
  compartment_id = var.compartment_ocid
  
  display_name = "lb_tcb"
  network_security_group_ids = [oci_core_network_security_group.nsg_tcb.id]
  
  subnet_ids = [
    oci_core_subnet.tcb_subnet.id
  ]

  shape = "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = 10
      minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_backendset" "test_backend_set" {
  health_checker {
    protocol = "TCP"
    interval_ms = "10000"
    port = "80"
    retries = "3"
    timeout_in_millis = "3000"
  }
  load_balancer_id = oci_load_balancer.test_load_balancer.id
  name = "bs-lb-tcb"
  policy = "ROUND_ROBIN"
}

resource "oci_load_balancer_listener" "listener" {
  default_backend_set_name = oci_load_balancer_backendset.test_backend_set.name
  load_balancer_id = oci_load_balancer.test_load_balancer.id
  name = "listener-lb-tcb"
  port = 80
  protocol = "HTTP"
}

resource "oci_load_balancer_backend" "backend-ws1" {
  count               = var.machine_amount
  load_balancer_id = oci_load_balancer.test_load_balancer.id
  backendset_name = oci_load_balancer_backendset.test_backend_set.name
  ip_address ="${element(oci_core_instance.webserver1.*.public_ip, count.index)}"
  
  port = 80
  backup = false
  drain = false
  offline = false
  weight = 1
}

output "lb_private_ip" {
  value = [oci_load_balancer.test_load_balancer.ip_address_details]
}
