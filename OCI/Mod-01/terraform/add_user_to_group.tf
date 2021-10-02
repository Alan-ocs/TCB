resource "oci_identity_user_group_membership" "Add_user_CloudAdmin_Group" {
    group_id = oci_identity_group.CloudAdmin.id
    user_id = oci_identity_user.Alan.id
}

resource "oci_identity_user_group_membership" "Add_user_to_DBA_Group" {
    group_id = oci_identity_group.DBA.id
    user_id = oci_identity_user.Alan.id
}