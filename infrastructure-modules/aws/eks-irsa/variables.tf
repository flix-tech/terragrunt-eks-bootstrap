variable "region" {
  default = "eu-west-2"
}

variable "cluster_name" {
  type = string
}

variable "ondemand_asg_max_size" {
  type = number
}

variable "spot_asg_max_size" {
  type = number
}

variable "ondemand_instance_types" {
  type = list(string)
}

variable "spot_instance_types" {
  type = list(string)
}