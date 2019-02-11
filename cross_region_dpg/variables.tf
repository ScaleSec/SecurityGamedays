variable "public_key" {
  description = "Your ssh public key so you can SSH into the instances you're creating"
}

variable "desired_capacity" {
  description = "How many instances should spin up?"
  default = 3
}

variable "target" {
  description = "The HTTP/S endpoint to submit the login request to"
}
