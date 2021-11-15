resource "aws_iam_group_policy_attachment" "CloudAdmin-AdministratorAccess" {
    group = "CloudAdmin"
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    depends_on = [aws_iam_group.CloudAdmin]
}

resource "aws_iam_group_policy_attachment" "DBA-RDSFullAccess" {
    group = "DBA"
    policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
    depends_on = [aws_iam_group.DBA]
}


resource "aws_iam_group_policy_attachment" "LinuxAdmin-EC2FullAccess" {
    group = "LinuxAdmin"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    depends_on = [aws_iam_group.LinuxAdmin]
}


resource "aws_iam_group_policy_attachment" "RedesAdmin-VPCFullAccess" {
    group = "RedesAdmin"
    policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
    depends_on = [aws_iam_group.RedesAdmin]
}


resource "aws_iam_group_policy_attachment" "Estagiarios-ReadOnly" {
    group = "Estagiarios"
    policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    depends_on = [aws_iam_group.Estagiarios]
}