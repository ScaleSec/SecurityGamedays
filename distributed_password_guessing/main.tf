provider "aws" {
  region = "${var.region}"
}

data "template_file" "dpg" {
  template = "${file("templates/dpg.sh")}"
  vars = {
    password_file = "${var.password_file}"
    target = "${var.target}"
    username_field = "${var.username_field}"
    password_field = "${var.password_field}"
    username_target = "${var.username_target}"
    interval = "${var.interval}"
    is_json_request = "${var.is_json_request}"
    is_custom = "${var.is_custom}"
    custom_curl_command = "${var.custom_curl_command}"
  }
}

data "template_file" "service" {
  template = "${file("templates/dpg.service")}"
}

data "template_file" "init" {
  template = "${file("templates/user-data.sh")}"
  vars = {
    password_file = "${var.password_file}"
    dpg_script_rendered = "${data.template_file.dpg.rendered}"
    service_rendered = "${data.template_file.service.rendered}"
  }
}

data "aws_ami" "amznlinux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20181114-x86_64-gp2"]
  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "tmp-dpg-deploy-key"
  public_key = "${var.public_key}"
}

resource "aws_launch_configuration" "amznlinux" {
  name = "DistributedPasswordGuessingScenario"
  instance_type = "t2.micro"
  image_id = "${data.aws_ami.amznlinux.id}"
  key_name = "${aws_key_pair.deployer.key_name}"
  user_data = "${data.template_file.init.rendered}"
  security_groups = ["${aws_security_group.dpg.id}"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "dpg" {
  name                 = "DistributedPasswordGuessingScenario"
  launch_configuration = "${aws_launch_configuration.amznlinux.name}"
  max_size             = "${var.desired_capacity}"
  min_size             = "${var.desired_capacity}"
  desired_capacity     = "${var.desired_capacity}"
  vpc_zone_identifier  = ["${aws_subnet.subnet.*.id}"]
}
