node_name  = "consul-client2"
server     = false
datacenter = "dc1"
log_level  = "INFO"
retry_join = ["${server-private-addr}"]
log_level  = "INFO"
data_dir   = "/opt/consul/data"
client_addr = "127.0.0.1 {{GetPrivateIP}}"
ports {
  grpc = 8502
}
bind_addr       = "{{GetPrivateIP}}"

license_path = "/etc/consul.d/consul.hclic"
