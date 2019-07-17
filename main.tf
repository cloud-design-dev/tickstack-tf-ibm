resource "random_id" "influx_pw" {
  byte_length = 8
}

resource "random_id" "chronograf_pw" {
  byte_length = 8
}

resource "random_id" "telegraf_pw" {
  byte_length = 8
}

resource "random_id" "salt" {
  byte_length = 8
}


# Create our Tick Stack instance 
resource "ibm_compute_vm_instance" "tick" {
  hostname             = "tick-${var.datacenter["us-east2"]}"
  domain               = "${var.domain}"
  os_reference_code    = "${var.os_reference_code["u16"]}"
  datacenter           = "${var.datacenter["us-east2"]}"
  network_speed        = 1000
  hourly_billing       = true
  private_network_only = false
  user_metadata        = "${file("install.yml")}"
  flavor_key_name      = "${var.flavor_key_name["medium"]}"
  tags                 = ["ryantiffany", "${var.datacenter["us-east2"]}"]
  local_disk           = false
}

# Create a temp inventory file to run Playbooks against 
resource "local_file" "ansible_hosts" {
  content = <<EOF
[instances]
tick ansible_host=${ibm_compute_vm_instance.tick.ipv4_address} ansible_user=deployer

EOF

  filename = "${path.cwd}/Hosts/inventory.env"
}

resource "dnsimple_record" "tick_dns" {
  domain = "${var.domain}"
  name   = "chronograf"
  value  = "${ibm_compute_vm_instance.tick.ipv4_address}"
  type   = "A"
  ttl    = 3600
}


resource "local_file" "tickstack" {
  content = <<EOF
${data.template_file.tickstack.rendered}
EOF

  filename = "${path.cwd}/Playbooks/tick-stack.yml"
}
