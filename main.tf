resource "aws_instance" "this" {
  count         = "${var.count}"
  instance_type = "${var.instance_type}"
  ami           = "${var.ami}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
    delete_on_termination = "${var.delete_on_termination}"
  }

  credit_specification {
    cpu_credits = "${var.cpu_credits}"
  }

  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  subnet_id              = "${element(var.subnets, count.index % length(var.subnets))}"
  iam_instance_profile   = "${var.iam_instance_profile}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  disable_api_termination     = "${var.protect_termination}"
  ebs_optimized           = "${var.ebs_optimized}"

  tags {
    Name = "${var.namespace == "" ? "" : "${lower(var.namespace)}-"}${lower(var.project_env_short)}-${lower(var.name)}-${format("%02d", count.index + 1)}"
    Env  = "${var.project_env}"
  }
}

//////////////////////////////////////////////
////// CloudWatch:
//////////////////////////////////////////////
data "aws_region" "this" {}
resource "aws_cloudwatch_metric_alarm" "ec2_recover" {
  count               = "${var.ec2_autorecover ? 1 : 0}"
  alarm_name          = "ec2-recovery-${lower(var.name)}"
  namespace           = "AWS/EC2"
  evaluation_periods  = "${var.cw_eval_periods}"
  period              = "${var.cw_period}"
  alarm_description   = "Auto recover ${lower(var.name)} instance"
  alarm_actions       = ["arn:aws:automate:${data.aws_region.this.name}:ec2:recover"]
  statistic           = "${var.cw_statistic}"
  comparison_operator = "${var.cw_comparison}"
  threshold           = "${var.cw_threshold}"
  metric_name         = "${var.cw_recover_metric}"

  dimensions {
    InstanceId = "${aws_instance.this.id}"
  }
}
