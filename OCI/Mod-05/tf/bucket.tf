resource "oci_objectstorage_bucket" "bucket1" {
  compartment_id = var.compartment_ocid
  namespace      = "desenvolvimento"
  name           = "tcbvideobackupaocs"
  access_type    = "NoPublicAccess"
  auto_tiering = "Disabled"
}

data "oci_objectstorage_namespace" "desenvolvimento" {
}

resource "oci_identity_tag_namespace" "tag_namespace" {

    compartment_id = var.compartment_ocid
    description = "desenvolvimento"
    name = "desenvolvimento"

    defined_tags = {"aplicacao"= "STATIC VALUE"}
    is_retired = false
}

resource "oci_identity_dynamic_group" "dynamic_group" {
 
    compartment_id = var.tenancy_ocid
    description = "videobackup"
    matching_rule = "tag.desenvolvimento.aplicacao.value='videobackup'"
    name = "videobackup"
}

resource "oci_identity_policy" "VideoBackupPolicy" {
    compartment_id = var.tenancy_ocid
    description = "VideoBackupPolicy"
    name = "VideoBackupPolicy"
    statements = ["Allow dynamic-group videobackup to manage objects in compartment recursosArmazenamento"]
}