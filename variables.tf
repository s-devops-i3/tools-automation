variable "tool_name" {
  default = {
    prometheus = {
      instance_type = "t3.small"
    }
  }
}

variable "zone_id" {}