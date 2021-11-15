resource "aws_iam_group" "CloudAdmin" {
  name = "CloudAdmin"
  path = "/"
}

resource "aws_iam_group" "DBA" {
  name = "DBA"
  path = "/"
}

resource "aws_iam_group" "LinuxAdmin" {
  name = "LinuxAdmin"
  path = "/"
}

resource "aws_iam_group" "RedesAdmin" {
  name = "RedesAdmin"
  path = "/"
}

resource "aws_iam_group" "Estagiarios" {
  name = "Estagiarios"
  path = "/"
}