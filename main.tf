module "ec2" {
  for_each = var.tool_name
  source = "./module"

  instance_type = each.value["instance_type"]
  tool_name  = each.key
  zone_id = var.zone_id
}