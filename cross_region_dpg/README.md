# Cross Region DPG

This is an example terraform module using the adjacent [distributed_password_guessing](../distributed_password_guessing/README.md) module, but across 3 separate continents. You can use this to test your SOC's response to multiple regions and verify where attacks are coming from.

**WARNING**: Only use this terraform module within the context of a valid and well-communicated test scenario. Using this code can lead to a DDoS which is illegal. ScaleSec is not responsible for misuse of the code herein.

## Running

1. Install [terraform](https://terraform.io/downloads.html)
2. Make any necessary changes to the script or variables to suite your test case
3. Get your SSH public key ready as well as the endpoint you'll be using since Terraform will prompt you for these things
4. Run `terraform apply` from this directory
5. Clean up: `terraform destroy`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| desired\_capacity | How many instances should spin up? | string | `"3"` | no |
| public\_key | Your ssh public key so you can SSH into the instances you're creating | string | n/a | yes |
| target | The HTTP/S endpoint to submit the login request to | string | n/a | yes |
