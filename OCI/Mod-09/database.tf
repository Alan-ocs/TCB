data "oci_database_autonomous_databases" "tcb_autonomous_database" {
  compartment_id = var.compartment_ocid
  db_workload  = "DW"
  is_free_tier = "true"
}

resource "oci_database_autonomous_database" "tcb_autonomous_database" {
  admin_password           = "Welcome123456" 
  compartment_id           = var.compartment_ocid
  cpu_core_count           = "1"
  data_storage_size_in_tbs = "1"
  db_name                  = "dbrh"
  db_workload              = "TP"
  display_name             = "dbrh"
  license_model            = "LICENSE_INCLUDED"
  is_free_tier             = "true"
}