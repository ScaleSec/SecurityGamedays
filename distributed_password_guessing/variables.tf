variable "public_key" {
  description = "Your ssh public key so you can SSH into the instances you're creating"
}

variable "region" {
  default = "us-west-2"
}

variable "availability_zones" {
  default = ["a", "b", "c"]
}

variable "desired_capacity" {
  description = "How many instances should spin up?"
  default = 3
}

variable "password_file" {
  description = "URL of text file to download with a list of passwords"
  default = "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt"
}

variable "target" {
  description = "The HTTP/S endpoint to submit the login request to"
}

variable "username_field" {
  description = "The name of the username field in the login request"
  default = "username"
}

variable "password_field" {
  description = "The name of the password field in the login request"
  default = "password"
}

variable "username_target" {
  description = "Since this is just a test, we will only test one username against the password list. This is that username or email."
  default = "bob@example.com"
}

variable "interval" {
  description = "How often does the login request happen in seconds"
  default = 10
}

variable "is_json_request" {
  description = "If this is a JSON type login request 1, for form login 0. You'll need to update the user_data script if you need other formats."
  default = "true"
}

variable "is_custom" {
  description = "Whether or not to use the custom_curl_command attribute instead of the default curl commands in user data."
  default = ""
}

variable "custom_curl_command" {
  description = "If your application does not match a basic username/password login request, you can pass in an arbitrary curl command which will be executed on an interval. This command should include the target endpoint."
  default = ""
}
