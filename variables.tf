variable ibm_bx_api_key {
  type    = "string"
  default = ""
}

variable ibm_sl_username {
  type    = "string"
  default = ""
}

variable ibm_sl_api_key {
  type    = "string"
  default = ""
}

variable datacenter {
  type = "map"

  default = {
    us-south1 = "dal10"
    us-south2 = "dal12"
    us-south3 = "dal13"
    us-east1  = "wdc04"
    us-east2  = "wdc06"
    us-east3  = "wdc07"
  }
}

variable os_reference_code {
  type = "map"

  default = {
    u16  = "UBUNTU_16_64"
    deb9 = "DEBIAN_9_64"
  }
}

variable flavor_key_name {
  type = "map"

  default = {
    medium = "B1_8X16X100"
  }
}

variable domain {
  type    = "string"
  default = "cdetesting.com"
}

variable dnsimple_token {
  type    = "string"
  default = ""
}

variable dnsimple_account {
  type    = "string"
  default = ""
}

variable chron_oauth_secret {
  type    = "string"
  default = ""
}

variable gh_org {
  type    = "string"
  default = ""
}

variable chron_oauth_id {
  type    = "string"
  default = ""
}