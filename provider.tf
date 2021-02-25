terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.1.3"
    }
  }
}

provider "vultr" {
  api_key = var.vultr_token
  rate_limit = 650
  retry_limit = 5
}
