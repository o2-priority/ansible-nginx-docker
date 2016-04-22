nginx-docker
==================

This role runs nginx container as a proxy for docker containers registered with
Consul. 
This role obtains service objects data registered with Consul for a given
microservice/applicatoin and configures nginx docker container as a proxy for
expose services.

In the context service object as explained in [Registrator] documentation, 
note that each listening port is considered a service.

## Assumptions

This role assumes that:
- service discovery backend is Consul
- services are registered on Consul using [Registrator]

So it may help to familiarise yourself with Registrator, consul and consul-template.


## Example

Configuring services exposed by a container e.g. jenkins docker container that
listens on ports 8080 and 50000.

```
- hosts: myhost

  vars:
    nginx_docker_consul_host: "<consul_host_ip|fqdn>"
    nginx_docker_consul_port: 8500

  roles:
    - { role: wunzeco.nginx-docker,
        nginx_docker_container_name: jenkins,
        nginx_docker_container_port:   8080,
        nginx_docker_http_location_prefix: '/jenkins',
        nginx_docker_http_uri: '' }
    - { role: wunzeco.nginx-docker,
        nginx_docker_container_name: jenkins,
        nginx_docker_container_port: 50000,
        nginx_docker_http_location_prefix: '/jenkins-agent',
        nginx_docker_http_uri: '' }

```

Ensure that `nginx\_docker\_container\_port` and `nginx\_docker\_http\_location\_prefix`
pair are unique.

> **IMPORTANT to note:**
>
>    Registrator considers anything listening on a port a **service**. So if a
>    container listens on multiple ports, it has multiple services.
>    (source: http://gliderlabs.com/registrator/latest/user/services/)

## Dependencies
none

[Registrator]: (http://gliderlabs.com/registrator/latest/
