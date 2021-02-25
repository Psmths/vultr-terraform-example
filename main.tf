resource "vultr_instance" "web" {
    plan = var.plan
    region = var.region
    os_id = var.os
    label = var.label
    hostname = var.hostname
    ssh_key_ids = ["${vultr_ssh_key.my_user.id}"]
    script_id = vultr_startup_script.standup.id
    firewall_group_id = vultr_firewall_group.my_firewall_grp.id
}

resource "vultr_ssh_key" "my_user" {
  name = "Root SSH key"
  ssh_key = "${file("sshkey.pub")}"
}

resource "vultr_startup_script" "standup" {
    name = "apache2-deploy"
    script = filebase64("startup.sh")
    type = "boot"
}

resource "vultr_dns_domain" "my_domain" {
    domain = "example.com"
    ip = vultr_instance.web.main_ip
}
