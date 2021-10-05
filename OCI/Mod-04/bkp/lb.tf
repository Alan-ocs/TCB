resource "opc_lbaas_load_balancer" "lb1" {
  name        = "TCB_LB"
  region      = var.region
  description = "My Example Load Balancer"
  scheme      = "INTERNET_FACING"
  permitted_methods = ["GET", "HEAD", "POST"]
  ip_network        = "/Compute-${var.domain}/${var.user}/ipnet1"
}

resource "opc_lbaas_server_pool" "serverpool1" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"
  name          = "serverpool1"
  servers  = ["webserver01:8080", "webserver02:8080"]
  vnic_set = "/Compute-${var.domain}/${var.user}/vnicset1"
}

resource "opc_lbaas_listener" "listener1" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"
  name          = "http-listener"
  balancer_protocol = "HTTP"
  port              = 80
  server_protocol = "HTTP"
  server_pool     = "${opc_lbaas_server_pool.serverpool1.uri}"
  policies = [
    "${opc_lbaas_policy.load_balancing_mechanism_policy.uri}",
  ]
}

resource "opc_lbaas_policy" "load_balancing_mechanism_policy" {
  load_balancer = "${opc_lbaas_load_balancer.lb1.id}"
  name          = "roundrobin"
  load_balancing_mechanism_policy {
    load_balancing_mechanism = "round_robin"
  }
}

output "canonical_host_name" {
  value = "${opc_lbaas_load_balancer.lb1.canonical_host_name}"
}

