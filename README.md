# POC for runninng Consul on Bare Metal(EC2) and Envoy on Docker for a service mesh configuration.

## Objective -  Running Envoy as a Docker sidecar for supporting service mesh and socket registration for services.

This is a Proof of Concept for running Envoy as Docker container and this configuration does not support Envoy Dynamic Configuration.
Please refer connect documention for details on Bootstrap and Dynamic Configuration.

Reference: https://www.consul.io/docs/connect/proxies/envoy

### Procedure:

1. - Setup Consul Server and Client configuration ( Example configuration in config Directory)
``` 
root@ip-172-31-20-20:/etc/consul.d# consul members
Node             Address             Status  Type    Build       Protocol  DC   Partition  Segment
consul-server-1  172.31.20.20:8301   alive   server  1.12.2+ent  2         dc1  default    <all>
consul-client    172.31.27.160:8301  alive   client  1.12.2+ent  2         dc1  default    <default>
consul-client2   172.31.26.241:8301  alive   client  1.12.2+ent  2         dc1  default    <default>
root@ip-172-31-20-20:/etc/consul.d#
```

2. - Deploy a Service on Bare metal (I have used EC2 Instance on AWS) using service and connect configuration ( Example in service Directory)

      Service url : https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/counting-service_linux_amd64.zip


3. - Rename this service to api-service and start your service using api.sh. Register this service to Consul 

     ` consul services register api.hcl `

4. - Generate Envoy Bootstrap configuration using `consul connect envoy -sidecar-for=api-1  -bootstrap > bootstrap.json`
5. - Start Envoy using this bootstaap configuration. I am mounting sidecar-config and sockets directory to docker container.

```
docker run -d --name envoy-consul -v /etc/consul.d/sidecar-config/:/tmp/consul/ -v /etc/consul.d/sockets/:/tmp/upstream_sockets/ -p 21000:21000 envoyproxy/envoy-distroless:v1.22.2 -c /tmp/consul/bootstrap.json -l trace
```

The webservice should get registetred to Consul. You can check the status using

```
$ consul catalog services
```

Check Sockets created on the host system, this information is also avaialable on Consul UI.

To check status of Envoy using docker commands.

```
docker ps
docker logs envoy-consul
```

This whole process can be updated using Docker Compose and shell scripting, you can find an example configuration in docker-compose.yml file

Please note I am using Envoy Bootstarp configuration generated for this POC service as an example.

Reference -  https://www.envoyproxy.io/docs/envoy/latest/configuration/overview/bootstrap

To Stop ( delete, clean up)
```
   docker stop envoy-consul
   docker rm envoy-consul
```



