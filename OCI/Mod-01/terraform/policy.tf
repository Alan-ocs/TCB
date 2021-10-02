resource "oci_identity_policy" "TenancyAdminPolicy" {
    compartment_id = var.tenancy_ocid
    description = "Admin access Group"
    name = "TenancyAdminPolicy"
    statements = [var.admin_policy_statements]
}

resource "oci_identity_policy" "DatabaseAdminPolicy" {
    compartment_id = var.tenancy_ocid
    description = "Admin access DBA Group"
    name = "DatabaseAdminPolicy"
    statements = [var.dba_policy_statements]
}