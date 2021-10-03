resource "oci_core_route_table" "Route_Rules" {

    compartment_id = var.DefaultRouteTable
    vcn_id = oci_core_vcn.vcn_mod04.id

    route_rules {

        network_entity_id = oci_core_internet_gateway.mod04_internet_gw.id

        destination = "0.0.0.0/0"
        destination_type = "internet gateway"
    }
    
  
}