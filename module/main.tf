resource "aws_instance" "instance" {
  for_each = var.tool_name
  ami                    = data.aws_ami.ami.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "record" {
  for_each = var.tool_name
  name    = each.key
  type    = "A"
  zone_id = var.zone_id
  records = [aws_instance.instance.public_ip]
  ttl     = 30
}