resource "vultr_firewall_group" "my_firewall_grp" {
    description = "Webserver Firewall"
}
resource "vultr_firewall_rule" "allow_http" {
    firewall_group_id = vultr_firewall_group.my_firewall_grp.id
    protocol = "tcp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "80"
}
resource "vultr_firewall_rule" "allow_https" {
    firewall_group_id = vultr_firewall_group.my_firewall_grp.id
    protocol = "tcp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "443"
}
resource "vultr_firewall_rule" "allow_ssh" {
    firewall_group_id = vultr_firewall_group.my_firewall_grp.id
    protocol = "tcp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "22"
}
