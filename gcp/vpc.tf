locals {
  ip_cidr_range  = "10.0.0.0/16"
  pods_cidr_range = "172.16.0.0/20"
  services_cidr_range = "192.168.0.0/24"
}

module "vpc" {
  providers = {
    google = google
    google-beta = google-beta
  }
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc?ref=688f2586414414b19e76e445a4b4a05242095571"

  project_id = local.project_id
  name       = local.name
  subnets = [
    {
      ip_cidr_range = local.ip_cidr_range
      name          = "${local.name}-${local.environment}"
      region        = local.region
      description   = "Subnet for ${local.name}-${local.environment}"
    
      secondary_ip_ranges = {
        pods     = { ip_cidr_range = local.pods_cidr_range }
        services = { ip_cidr_range = local.services_cidr_range }
      }
    },
  ]
}