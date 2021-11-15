resource "null_resource" "Execute_Ansible" {

 provisioner "local-exec" {

    command = "ansible-playbook createusers.yml"

  }
  depends_on = [aws_iam_group_policy_attachment.CloudAdmin-AdministratorAccess, aws_iam_group_policy_attachment.DBA-RDSFullAccess, aws_iam_group_policy_attachment.LinuxAdmin-EC2FullAccess, aws_iam_group_policy_attachment.RedesAdmin-VPCFullAccess, aws_iam_group_policy_attachment.Estagiarios-ReadOnly]
}
