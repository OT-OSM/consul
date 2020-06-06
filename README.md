Ansible Role | Consul
========================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Automated setup of consul cluster with below features.

Salient Features
--------------------
This repo consists of Ansible role to setup consul cluster of:
  - any number of agent server nodes
  - any number of agent client nodes

Version History
------------------
|**Date**| **Version**| **Description**| **Changed By** |
|----------|---------|---------------|-----------------|
|**1 June 2020** | v1.0.0 | Initial Draft | Shatrujeet |

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
| consul_binary_url | https://releases.hashicorp.com/consul/1.7.2/consul_1.7.2_linux_amd64.zip | Location to download consul binary |
| consul_data_dir | /opt/consul | Data storage directory for consul |
| datacenter | dc1 | Name of the datacenter |
| raft_mul | 1 | Value of raft_mul |

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


Example Playbook
-------------------

```
# consul.yml
---
- hosts: all
  become: true
  roles:
    - role: osm_java
```

Inventory
-----------------

Your inventory should look like below.
```
[consul-leader]
server1 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-server]
server2 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
server3 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-client]
client1 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
```

Ansible command
-------------------
```
ansible-playbook consul.yml
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