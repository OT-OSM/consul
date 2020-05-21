Ansible Role | Consul
========================

[![CircleCI](https://circleci.com/gh/OT-OSM/openvpn/tree/master.svg?style=svg)](https://app.circleci.com/pipelines/github/OT-OSM/openvpn?branch=master)


[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Automated setup of consul cluster with below added features.

Salient Features
--------------------
This repo consists of Ansible role to:
    * create consul-cluster of any number of nodes
    * add client to existing consul-cluster
    * add server to existing consul-cluster
    * add, modify and delete services under local consul-client

Version History
------------------
|**Date**| **Version**| **Description**| **Changed By** |
|----------|---------|---------------|-----------------|
|**22 May 2020** | v.1.0.0 | Initial Draft | Shatrujeet |

Supported OS
------------
  * Ubuntu:bionic
  * Ubuntu:xenial
  * Amazon AMI

Dependencies
------------
  * None 

Variables | vars/main.yml
----------------------------
Values required to update and modify by users are kept here.

|**Variables**| **Default Values**| **Description**|
|----------|---------|---------------|
| leader_priv_ip | " " | Private Ip of consul-cluster leader. Must to fill. |
| encrypt_key |  | Encryption key for gossip protocol. Must be same for all member of cluster. Leader once created find this in file /etc/consul.d/consul.hcl | 
| consul_binary_url | https://releases.hashicorp.com/consul/1.7.3/consul_1.7.3_linux_amd64.zip | Location to download consul binary |
| consul_version | Consul v1.7.3 | Version of consul |
| consul_data_dir | /opt/consul | Data storage directory for consul |
| datacenter | dc1 | Name of the datacenter |
| raft_mul | 1 | Value of raft_mul |
| service_name | nginx | Name of the service you want to register |
| service_port | 80 | Service port |
| health_check_interval | 60s | Interval for service status check |
| health_check_url | http://localhost:80/ | Url of service status check |

Variables | defaults/main.yml
--------------------------------

|**Variables**| **Default Values**| **Description**|
|----------|---------|---------------|
| consul_binary_dir | /usr/local/bin | Location to keep consul binary. Make sure this path is included in PATH environment variable |
| consul_binary_perm | 0440 | Permission for consul binary |
| consul_binary_owner | root | Owner of consul binary |
| consul_binary_group | root | Group of consul binary |
| consul_user_home | /etc/consul.d | Home directory for consul user |
| consul_user_shell | /bin/false | Shell assigned to consul user |
| consul_owner | consul | Consul data directory owner |
| consul_group | consul | Consul data directory group |
| consul_hcl_dest | /etc/consul.d/consul.hcl | Location to store consul configuration. Common for both server and client |
| consul_hcl_mode | 0640 | Permission for consul.hcl file |
| server_hcl_dest | /etc/consul.d/server.hcl | Location to store consul configuration. Only for server |
| server_hcl_mode | 0640 | Permission for server.hcl file |

Usage
--------
### For n node consul-cluster ###

1. At first you will have to create a leader
```hcl
ansible-playbook consul.yml --limit consul-leader
```
2. Then other server will join the leader. Before that you will have to update private Ip and encryption-key( find at /etc/consul.d/consul.hcl ) of leader server to vars/main.yml.
   Then run below command.
```hcl
ansible-playbook consul.yml --limit consul-server
```
### For adding consul clients to consul-cluster ###
```hcl
ansible-playbook consul.yml --limit consul-client
```
### For Adding Modifying and Deleting services to local consul client ###
```hcl
ansible-playbook consul.yml --limit consul-amd
```

Example Playbook
-------------------

```hcl
# consul.yml
---
-   hosts: all
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        -   import_role:
                name: ./osm_consul   ## you can give absolute or relative path to osm_consul
```

Inventory
-----------------

Your inventory should look like below.
```hcl
[consul-leader]
server1 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-server]
server2 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
server3 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-client]
client1 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-amd]
client-agent ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
```

Future changes
----------------
* support for CentOS
* TLS encryption for RPC protocol

References
-----------
* https://learn.hashicorp.com/consul/datacenter-deploy/deployment-guide

## License
* MIT / BSD

## Author Information

### Contributors
Shatrujeet