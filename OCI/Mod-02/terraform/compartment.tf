resource "oci_identity_compartment" "tf-compartment" {
    # Required
    compartment_id = "<tenancy-ocid>"
    description = "Compartment for Terraform resources."
    name = "<your-compartment-name>"
}
