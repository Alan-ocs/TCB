resource "oci_identity_compartment" "recursosRedes" {
    compartment_id = var.tenancy_ocid
    description = "Compartment for Network resources."
    name = "recursosRedes"
}

resource "oci_identity_compartment" "recursosCompute" {
    compartment_id = var.tenancy_ocid
    description = "Compartment for Compute resources."
    name = "recursosCompute"
}

resource "oci_identity_compartment" "recursosArmazenamento" {
    compartment_id = var.tenancy_ocid
    description = "Compartment for Storage resources."
    name = "recursosArmazenamento"
}

resource "oci_identity_compartment" "recursosDB" {
    compartment_id = var.tenancy_ocid
    description = "Compartment for Database resources."
    name = "recursosDB"
}

