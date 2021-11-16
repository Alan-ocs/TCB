resource "null_resource" "Run_Python_Script" {

 provisioner "local-exec" {

    # command = "ansible-playbook createusers.yml"
    command = "python3 createusers.py"

  }
  depends_on = [aws_iam_group_policy_attachment.CloudAdmin-AdministratorAccess, aws_iam_group_policy_attachment.DBA-RDSFullAccess, aws_iam_group_policy_attachment.LinuxAdmin-EC2FullAccess, aws_iam_group_policy_attachment.RedesAdmin-VPCFullAccess, aws_iam_group_policy_attachment.Estagiarios-ReadOnly]
}
