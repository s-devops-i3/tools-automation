module "ec2" {
  source = "./module"
  instance_type = var.instance_type
  tool_name  = var.tool_name["prometheus"]["name"]
  zone_id = var.zone_id
}