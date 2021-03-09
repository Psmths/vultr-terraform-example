# vultr-terraform-example
 Example demonstrating how to deploy an Apache 2 instance on Vultr using terraform. This terraform deployment will create a cheap Vultr instance complete with DNS and firewall, as well as an Apache 2 installation.

 Additional information can be found here:

- [Terraform Registry](https://registry.terraform.io/providers/vultr/vultr/latest/docs)
- [Official GitHub](https://github.com/vultr/terraform-provider-vultr)

## Information

### Startup Script

Because Vultr expects the script to be passed in Base64 encoding, we can use Terraform's `filebase64` functionality to automatically encode a file in base64 and pass it to this instance, like so:

```
resource "vultr_startup_script" "standup" {
    name = "apache2-deploy"
    script = filebase64("startup.sh")
    type = "boot"
}
```

The startup script is applied to the instance (referenced by id) with this line in the main instance resource:
```
script_id = vultr_startup_script.standup.id
```

### SSH Keys

This terraform deployment will also add an authorized SSH key to the root account. The relevant provider is as follows, and is self-explanatory:

```
resource "vultr_ssh_key" "my_user" {
  name = "Root SSH key"
  ssh_key = "${file("sshkey.pub")}"
}
```

The SSH key is applied to the instance in the main instance provider as follows:

```
ssh_key_ids = ["${vultr_ssh_key.my_user.id}"]
```

### DNS Records

The provider for DNS records creates a new DNS entry and ties it to the instance's IP address. In this provider entry, `vultr_instance.web.main_ip` will become the `web` instance's IP address as soon as terraform knows what it is.

```
resource "vultr_dns_domain" "my_domain" {
    domain = "example.com"
    ip = vultr_instance.web.main_ip
}
```
### tfvars

The file `terraform.tfvars` contains all of the variable assignments listed in `variable.tf`. To obtain these values, use `vultr-cli`, which can be found [here](https://github.com/vultr/vultr-cli). We see these values applied to the main instance provider as shown below:

```
plan = var.plan
region = var.region
os_id = var.os
label = var.label
hostname = var.hostname
```

### Firewall

This deployment creates a firewall group, adds rules to this group, and assigns the group to the instance. It first creates the group as follows:

```
resource "vultr_firewall_group" "my_firewall_grp" {
    description = "Webserver Firewall"
}
```

This group is then applied to the main instance:
```
firewall_group_id = vultr_firewall_group.my_firewall_grp.id
```

### Output

The output provider in `output.tf` simply prints the instance's final IP address after the deployment is complete.

## Deploying
To deploy this instance, simply issue the following commands:
```
terraform init
terraform plan
terraform apply
```
