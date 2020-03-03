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
variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = " "
}

// CloudWatch:
variable "ec2_autorecover" { default = true }
variable "cw_eval_periods" { default = "2" }
variable "cw_period" { default = "60" }
variable "cw_statistic" { default = "Minimum" }
variable "cw_comparison" { default = "GreaterThanThreshold" }
variable "cw_threshold" { default = "0.0" }
variable "cw_recover_metric" { default = "StatusCheckFailed_System" }
