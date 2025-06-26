variable "instance_type" {}

variable "tool_name" {
  default = {
    prometheus = {
      name = "Prometheus"
    }
  }
}

variable "zone_id" {}