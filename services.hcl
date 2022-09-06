service {
  name = "web"
  port = 8080
  connect {
    sidecar_service {
      proxy {
        upstreams {
          destination_name = "api"
          local_bind_socket_path = "/tmp/upstream_sockets/api.sock"
          local_bind_socket_mode = "0777"
        }

        upstreams {
          destination_name = "db"
          local_bind_socket_path = "/tmp/upstream_sockets/db.sock"
          local_bind_socket_mode = "0777"
        }
      }
    }
  }
}
