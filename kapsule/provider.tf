provider "scaleway" {
  access_key      = var.scaleway_access_key
  secret_key      = var.scaleway_secret_key
  region          = var.region
  zone            = var.zone
  organization_id = var.project_id
}
