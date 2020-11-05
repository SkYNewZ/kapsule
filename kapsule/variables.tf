variable "scaleway_access_key" {
  type        = string
  description = "Scaleway project access key"
}

variable "scaleway_secret_key" {
  type        = string
  description = "Scaleway project secret key"
}

variable "project_id" {
  type        = string
  description = "Scaleway project to use"
}

variable "zone" {
  type    = string
  default = "fr-par-1"
}

variable "region" {
  type    = string
  default = "fr-par"
}

locals {
  tags = ["terraform"]
}
