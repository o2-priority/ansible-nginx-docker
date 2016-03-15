nginx-consul
==================

This role runs nginx container as a proxy for docker containers registered with
Consul. 

## Requirements

- Consul backend

## Example

```
- hosts: myhost

  vars:
    nginx_consul_backend_host: <consul_host_fqdn|ip>
    nginx_consul_backend_port: 8500

  roles:
    - wunzeco.nginx-consul
```

## Dependencies
none
