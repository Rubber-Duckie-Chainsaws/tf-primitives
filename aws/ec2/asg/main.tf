locals {
  tags = concat([
    {TagKey = "terraform", TagValue = "true", propagate=true},
    {TagKey = "Name", TagValue = var.name, propagate=true}
   ], var.tags)

  launch_template = length(var.mixed_instances) == 0 ? [{LT_ID=var.launch_template_id, LT_Version=var.launch_template_version}] : []
  mixed_instance_policy = length(var.mixed_instances) > 0 ? [{
    LT_ID=var.launch_template_id,
    LT_Overrides=var.mixed_instances
  }] : []
}

resource "consul_keys" "id" {
  datacenter = "aws-nyc-1"

  key {
    path = "services/${var.name}/autoscaling_group/id"
    value = "${aws_autoscaling_group.this.id}"
  }
}

resource "consul_keys" "name" {
  datacenter = "aws-nyc-1"

  key {
    path = "services/${var.name}/autoscaling_group/name"
    value = "${aws_autoscaling_group.this.name}"
  }
}

resource "aws_autoscaling_group" "this" {
  name_prefix  = "${var.name}-"
  max_size     = var.max_size
  min_size     = var.min_size
  desired_capacity = var.desired_capacity
  desired_capacity_type = "units"

  vpc_zone_identifier = var.vpc_zone_identifier
  # termination_policies =

  dynamic "launch_template" {
    for_each = local.launch_template
    content {
      id = launch_template.value["LT_ID"]
      version = launch_template.value["LT_Version"]
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = local.mixed_instance_policy
    content {
      instances_distribution {
        on_demand_percentage_above_base_capacity = var.distribution_percentage
        spot_allocation_strategy = "price-capacity-optimized"
      }

      launch_template {
        launch_template_specification {
          launch_template_id = mixed_instances_policy.value["LT_ID"]
        }

        dynamic "override" {
          for_each = mixed_instances_policy.value["LT_Overrides"]
          content {
            instance_type = override.value["instance_type"]
            weighted_capacity = override.value["weighted_capacity"]
          }
        }
      }
    }
  }

  dynamic "tag" {
    for_each = local.tags
    content {
      key =  tag.value["TagKey"]
      value = tag.value["TagValue"]
      propagate_at_launch = tag.value["propagate"]
    }
  }

  max_instance_lifetime = var.max_instance_lifetime

  # Will be great for AMI rollouts
  # instance_refresh =

  # Consider using for GHA worker nodes
  # warm_pool =

  lifecycle {
    ignore_changes = [
      desired_capacity,
    ]
  }
}
