resource "oci_core_drg" "tcb_drg" {
    
    compartment_id = var.recursosRedes
    display_name = "tcb_drg"

}

resource "oci_core_drg_attachment" "tcb_drg_attachment" {

    drg_id = oci_core_drg.tcb_drg.id
    network_details {
        id = oci_core_vcn.tcb_vcn.id
        type = "VCN"
      
    }
  
}

# resource "oci_core_drg_route_table_route_rule" "Update_Route_Table" {

#     drg_route_table_id = var.DefaultRouteTable
#     destination = oci_core_drg.tcb_drg.id
#     destination_type = "0.0.0.0/0"
#     next_hop_drg_attachment_id = oci_core_drg_attachment.Update_Route_Table.id

# }