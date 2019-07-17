data "template_file" "tickstack" {
  template = "${file("${path.cwd}/Templates/tick-stack.yml.tpl")}"

  vars = {
    fqdn               = "chronograf.${var.domain}"
    admin_pass         = "${random_id.influx_pw.hex}"
    chronograf_pw      = "${random_id.chronograf_pw.hex}"
    telegraf_pw        = "${random_id.telegraf_pw.hex}"
    salt               = "${random_id.salt.hex}"
    chron_oauth_id     = "${var.chron_oauth_id}"
    chron_oauth_secret = "${var.chron_oauth_secret}"
    gh_org             = "${var.gh_org}"
  }
}
