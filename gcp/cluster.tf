module "cluster" {
  providers = {
    google = google
    google-beta = google-beta
  }
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-cluster-autopilot?ref=688f2586414414b19e76e445a4b4a05242095571"

  project_id = local.project_id
  name       = local.name
  location   = local.location

  deletion_protection = true

  access_config = {
    ip_access = {
      gcp_public_cidrs_access_enabled = true
      authorized_ranges = {
        internal-vms = "10.0.0.0/8"
      }
    }
  }

  vpc_config = {
    network    = module.vpc.network.self_link
    subnetwork = module.vpc.subnets["${local.region}/${local.name}-${local.environment}"].self_link
    secondary_range_names = {
      pods     = "pods"
      services = "services"
    }
  }

  enable_features = {
    anonymous_authentication = "LIMITED"
  }

  logging_config = {
    enable_api_server_logs         = true
    enable_scheduler_logs          = true
    enable_controller_manager_logs = true
  }

  monitoring_config = {
    enable_api_server_metrics         = true
    enable_controller_manager_metrics = true
    enable_scheduler_metrics          = true

    enable_cadvisor_metrics    = true
    enable_daemonset_metrics   = true
    enable_deployment_metrics  = true
    enable_hpa_metrics         = true
    enable_pod_metrics         = true
    enable_statefulset_metrics = true
    enable_storage_metrics     = true
  }
  
  labels = local.labels
}
