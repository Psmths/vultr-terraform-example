variable "vultr_token" {
    description   = "Vultr API token"
    type          = string
}

variable "os" {
    description   = "Vultr OS"
    type          = string
}

variable "plan" {
    description   = "Vultr Plan"
    type          = string
}

variable "label" {
    description   = "Vultr Server Name Labeling"
    type          = string
}

variable "region" {
    description   = "Vultr Region"
    type          = string
}

variable "hostname" {
    description   = "Resource hostname"
    type          = string
}
