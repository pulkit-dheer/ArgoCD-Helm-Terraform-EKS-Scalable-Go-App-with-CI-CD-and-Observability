resource "aws_security_group" "my-cluster-sg" {
  name_prefix = "my-cluster-sg"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "my-cluster-sg-rules-ingress" {
  description       = "allow inbound traffic from eks"
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  security_group_id = aws_security_group.my-cluster-sg.id
  type              = "ingress"
  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
  ]
}

resource "aws_security_group_rule" "my-cluster-sg-rules-egress" {
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.my-cluster-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}