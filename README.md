nginx-docker
==================

This role runs nginx container as a proxy for docker containers registered with
Consul. 

## Assumptions

This role assumes that:
- service discovery backend is Consul
- services are registered on Consul using [Registrator](http://gliderlabs.com/registrator/latest/)

So it may help to familiarise yourself with Registrator, consul and consul-template.


## Example


```
- hosts: myhost

  vars:
    nginx_docker_consul_host: "<consul_host_ip|fqdn>"
    nginx_docker_consul_port: 8500

  roles:
    - { role: wunzeco.nginx-docker,
        nginx_docker_container_name: jenkins,
        nginx_docker_service_name:   jenkins-8080,
        nginx_docker_http_location_prefix: '/jenkins',
        nginx_docker_http_uri: '' }
    - { role: wunzeco.nginx-docker,
        nginx_docker_container_name: jenkins,
        nginx_docker_service_name:   jenkins-50000,
        nginx_docker_http_location_prefix: '/jenkins-agent',
        nginx_docker_http_uri: '' }

```

Ensure that `nginx\_docker\_service\_name` and `nginx\_docker\_http\_location\_prefix`
are unique.

> **IMPORTANT to note:**
>
>    Registrator considers anything listening on a port a **service**. So if a
>    container listens on multiple ports, it has multiple services.
>    (source: http://gliderlabs.com/registrator/latest/user/services/)

## Dependencies
none
