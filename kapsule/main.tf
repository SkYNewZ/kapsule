resource "scaleway_k8s_cluster_beta" "cluster" {
  name             = "skynewz-cloud"
  description      = "My cluster"
  version          = "1.18.10"
  cni              = "cilium"
  enable_dashboard = false
  ingress          = "none"
  tags             = local.tags

  autoscaler_config {
    disable_scale_down            = false
    scale_down_delay_after_add    = "10m"
    scale_down_unneeded_time      = "10m"
    ignore_daemonsets_utilization = false
  }

  auto_upgrade {
    enable                        = false
    maintenance_window_start_hour = 1
    maintenance_window_day        = "any"
  }
}

resource "scaleway_k8s_pool_beta" "node_pool_1" {
  cluster_id = scaleway_k8s_cluster_beta.cluster.id
  name       = "node-pool-1"
  tags       = local.tags
  node_type  = "DEV1-M"

  size              = 1
  min_size          = 1
  max_size          = 2
  autoscaling       = true
  autohealing       = true
  container_runtime = "docker"

  wait_for_pool_ready = true
}

resource "local_file" "kubeconfig" {
  content  = scaleway_k8s_cluster_beta.cluster.kubeconfig[0].config_file
  filename = "/home/quentin/.kube/config"
}

# LB reserved IP
resource "scaleway_lb_ip_beta" "ip" {}

output "lb_public_ip" {
  value       = scaleway_lb_ip_beta.ip.ip_address
  description = "Reserved load balancer IP to use for DNS"
}
