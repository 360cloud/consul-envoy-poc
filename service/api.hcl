service {
  name = "api"
  id = "api-1"
  port = 9003

  connect {
    sidecar_service {
      proxy {
        upstreams {
          destination_name = "db-service"
          local_bind_socket_path = "/tmp/upstream_sockets/db-service.sock"
          local_bind_socket_mode = "0777"
        }
          }
              }
        }

  check {
    id       = "api-check"
    http     = "http://localhost:9003/health"
    method   = "GET"
    interval = "1s"
    timeout  = "1s"
  }
}
