resource "oci_core_vcn" "vcn-mod05" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "vcn-mod05"
  dns_label      = "vcn-mod05"
}

resource "oci_core_subnet" "subnet1" {

  cidr_block          = "10.0.0.0/24"
  display_name        = "subnet1"
  dns_label           = "subnet1"
  security_list_ids   = [oci_core_security_list.securitylist1.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.vcn-mod05.id
  route_table_id      = oci_core_route_table.routetable1.id
  dhcp_options_id     = oci_core_vcn.vcn-mod05.default_dhcp_options_id
  
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "oci_core_subnet" "subnet2" {

  cidr_block          = "10.0.1.0/24"
  display_name        = "subnet2"
  dns_label           = "subnet2"
  security_list_ids   = [oci_core_security_list.securitylist1.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.vcn-mod05.id
  route_table_id      = oci_core_route_table.routetable1.id
  dhcp_options_id     = oci_core_vcn.vcn-mod05.default_dhcp_options_id
  prohibit_public_ip_on_vnic = true

  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "oci_core_security_list" "securitylist1" {
  display_name   = "public"
  compartment_id = oci_core_vcn.vcn-mod05.compartment_id
  vcn_id         = oci_core_vcn.vcn-mod05.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 8080
      max = 8080
    }
  }
}

resource "oci_core_internet_gateway" "internetgateway1" {
  compartment_id = var.compartment_ocid
  display_name   = "internetgateway1"
  vcn_id         = oci_core_vcn.vcn-mod05.id
}

resource "oci_core_route_table" "routetable1" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn-mod05.id
  display_name   = "routetable1"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internetgateway1.id
  }
}