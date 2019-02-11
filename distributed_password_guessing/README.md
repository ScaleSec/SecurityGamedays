# Distributed Password Guessing Gameday

## Description
This will spin up a cluster of 3 nodes (by default) each with the task of trying to guess the password of a login API. The login API could be in the form of JSON, form data, or a custom curl request. You can adjust the script as you need in [templates/dpg.sh](templates/dpg.sh) depending on the app you're using. By default it will send a curl request something like this:

```
curl -X POST -H 'Content-Type: application/json' \
  -d '{"username": "bob@example.com", "password": "Secret123"}' \
  https://api.example.com
```

## Use Cases

* Determine how well your app responds to password guessing
* Determine how well the IR/SOC team is able to find these type of errors
* Can help determine how susceptible you are to DDoS attacks

**WARNING**: Only use this terraform module within the context of a valid and well-communicated test scenario. Using this code can lead to a DDoS which is illegal. ScaleSec is not responsible for misuse of the code herein.

## Running

1. Install [terraform](https://terraform.io/downloads.html)
2. Make any necessary changes to the script or variables to suite your test case
3. Get your SSH public key ready as well as the endpoint you'll be using since Terraform will prompt you for these things
4. Run `terraform apply` from this directory
5. Execute your Gameday exercises
  a. To obtain the IP addresses of the nodes you just created, you can run `./bin/instance_ips.sh`
  b. You can then verify the `dpg` executable is running by SSHing onto one of the nodes and running `sudo systemctl status dpg`
6. Clean up: `terraform destroy`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability\_zones |  | list | `["a", "b", "c"]` | no |
| custom\_curl\_command | If your application does not match a basic username/password login request, you can pass in an arbitrary curl command which will be executed on an interval. This command should include the target endpoint. | string | `""` | no |
| desired\_capacity | How many instances should spin up? | string | `"3"` | no |
| interval | How often does the login request happen in seconds | string | `"10"` | no |
| is\_custom | Whether or not to use the custom_curl_command attribute instead of the default curl commands in user data. | string | `""` | no |
| is\_json\_request | If this is a JSON type login request 1, for form login 0. You'll need to update the user_data script if you need other formats. | string | `"true"` | no |
| password\_field | The name of the password field in the login request | string | `"password"` | no |
| password\_file | URL of text file to download with a list of passwords | string | `"https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt"` | no |
| public\_key | Your ssh public key so you can SSH into the instances you're creating | string | n/a | yes |
| region |  | string | `"us-west-2"` | no |
| target | The HTTP/S endpoint to submit the login request to | string | n/a | yes |
| username\_field | The name of the username field in the login request | string | `"username"` | no |
| username\_target | Since this is just a test, we will only test one username against the password list. This is that username or email. | string | `"bob@example.com"` | no |
