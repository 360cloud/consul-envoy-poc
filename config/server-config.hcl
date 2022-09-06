node_name  = "consul-server-1"
datacenter = "dc1"
log_level  = "INFO"
server     = true
ui_config {
    enabled = true
}
connect {
  enabled = true
}
ports {
  grpc = 8502
}
domain     = "consul"
data_dir   = "/opt/consul/data"
bind_addr       = "0.0.0.0"
addresses {
    http = "0.0.0.0"
}
bootstrap_expect = 1
autopilot {
    redundancy_zone_tag = "az"
}
node_meta {
    az = "Zone1"
}
license_path = "/etc/consul.d/consul.hclic"
