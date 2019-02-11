module "dpg0" {
  source = "../distributed_password_guessing"
  desired_capacity = "${var.desired_capacity}"
  public_key = "${var.public_key}"
  target = "${var.target}"
  region = "us-west-1"
}

module "dpg1" {
  source = "../distributed_password_guessing"
  desired_capacity = "${var.desired_capacity}"
  public_key = "${var.public_key}"
  target = "${var.target}"
  region = "eu-west-1"
}

module "dpg2" {
  source = "../distributed_password_guessing"
  desired_capacity = "${var.desired_capacity}"
  public_key = "${var.public_key}"
  target = "${var.target}"
  region = "ap-southeast-2"
}
