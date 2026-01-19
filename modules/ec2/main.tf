# EC2 Instances
resource "aws_instance" "this" {
  count = var.instance_count
  
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name
  
  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size
    encrypted   = true
  }
  
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    project_name = var.project_name
    environment  = var.environment
  }))
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-instance-${count.index + 1}"
    }
  )
  
  lifecycle {
    create_before_destroy = true
  }
}

# Elastic IPs for public instances
resource "aws_eip" "this" {
  count    = var.assign_public_ip ? var.instance_count : 0
  instance = aws_instance.this[count.index].id
  domain   = "vpc"
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eip-${count.index + 1}"
    }
  )
}

# Auto Scaling Group (optional)
resource "aws_autoscaling_group" "this" {
  count = var.enable_auto_scaling ? 1 : 0
  
  name_prefix          = "${var.project_name}-asg-"
  vpc_zone_identifier  = var.subnet_ids
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  launch_configuration = aws_launch_configuration.this[0].name
  
  tag {
    key                 = "Name"
    value               = "${var.project_name}-asg-instance"
    propagate_at_launch = true
  }
  
  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_launch_configuration" "this" {
  count = var.enable_auto_scaling ? 1 : 0
  
  name_prefix          = "${var.project_name}-lc-"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = var.security_group_ids
  key_name             = var.key_name
  user_data            = base64encode(templatefile("${path.module}/user_data.sh", {
    project_name = var.project_name
    environment  = var.environment
  }))
  
  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size
    encrypted   = true
  }
  
  lifecycle {
    create_before_destroy = true
  }
}
