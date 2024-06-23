data "consul_keys" "ami" {
  datacenter = "aws-nyc-1"

  key {
    name = "ami"
    path = "gold/${var.class}/${var.env}/ami"
  }
}

resource "consul_keys" "id" {
  datacenter = "aws-nyc-1"

  key {
    path = "services/${var.name}/launch_template/id"
    value = "${aws_launch_template.this.id}"
  }
}

resource "aws_launch_template" "this" {
  name = "${var.name}-lt"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = var.root_volume_size
      volume_type           = "gp3"
      iops                  = 3000
      throughput            = 125
      delete_on_termination = true
    }
  }

  image_id = "${data.consul_keys.ami.var.ami}"
  instance_type = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  update_default_version = var.update_default_version

  dynamic "instance_market_options" {
    for_each = var.spot_instance_options
    content {
      market_type = "spot"
      spot_options {
        instance_interruption_behavior = instance_market_options.value["Interrupt"]
        max_price = instance_market_options.value["Price"]
        spot_instance_type = instance_market_options.value["SpotType"]
      }
    }
  }

  iam_instance_profile {
    name = var.instance_profile
  }

  user_data = filebase64("${path.module}/userdata.txt")
}
