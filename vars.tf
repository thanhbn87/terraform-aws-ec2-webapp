variable "name" {}
variable "namespace" { default = "" }
variable "project_env" { default = "Development" }
variable "project_env_short" { default = "dev" }
variable "instance_type" {}
variable "ami" {}
variable "count" { default = "1" }

variable "delete_on_termination" { default = false }
variable "iam_instance_profile" {}
variable "volume_size" { default = "8" }

variable "key_name" {}
variable "vpc_security_group_ids" { default = [] }
variable "subnets" { type = "list" }
variable "associate_public_ip_address" { default = false }
variable "protect_termination" { default = true }
variable "cpu_credits" { default = "standard" }
variable "ebs_optimized" { default = false }
