resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type             = "persistent"
      instance_interruption_behavior = "stop"
    }
  }

  tags = {
    Name = var.tool_name
  }
}

resource "aws_iam_role" "role" {
  name = "${var.tool_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "${var.tool_name}-role"
  }
}
  resource "aws_iam_policy" "describe_ec2_policy" {
    name = "describe_ec2_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = var.policy_resource_list
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.describe_ec2_policy.arn
}
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.tool_name}-role"
  role = aws_iam_role.role.name
}




resource "aws_route53_record" "record" {
   name    = var.tool_name
  type    = "A"
  zone_id = var.zone_id
  records = [aws_instance.instance.public_ip]
  ttl     = 30
}
resource "aws_route53_record" "int-record" {
  name    = "${var.tool_name}-internal"
  type    = "A"
  zone_id = var.zone_id
  records = [aws_instance.instance.private_ip]
  ttl     = 30
}