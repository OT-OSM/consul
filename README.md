# osm_consul

This repo consists of Ansible role to:

    1. create consul-cluster with any number of nodes

    2. add client to existing consul-cluster

    3. add server to existing consul-cluster

    4. add, modify, and delete services under local consul-client

Usage
--------
### For n node consul-cluster ###

1. Firstly you will have to create a leader
```hcl
ansible-playbook -i inventory leader.yml -t consul-leader-server --ssh-common-args='-o StrictHostKeyChecking=no'
```
```hcl
# leader.yml
---
-   hosts: [consul-leader-server]
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        - import_role:
            name: ./osm_consul   ## you can give absolute or relative path to osm_consul
```

2. Then you need to join other server with leader
```hcl
ansible-playbook -i inventory servers.yml -t consul-server --ssh-common-args='-o StrictHostKeyChecking=no'
```
```hcl
# servers.yml
---
-   hosts: [consul-servers]
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        - import_role:
            name: ./osm_consul   ## you can give absolute or relative path to osm_consul
```

### For adding consul clients to consul-cluster ###
```hcl
ansible-playbook -i inventory client.yml -t consul-client --ssh-common-args='-o StrictHostKeyChecking=no'
```
```hcl
# client.yml
---
-   hosts: [consul-clients]
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        - import_role:
            name: ./osm_consul   ## you can give absolute or relative path to osm_consul
```

### For Adding Modifying and Deleting services to local consul client ###
```hcl
ansible-playbook -i inventory amd.yml -t consul-amd --ssh-common-args='-o StrictHostKeyChecking=no'
```
```hcl
# amd.yml
---
-   hosts: [consul-amd]
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        - import_role:
            name: ./osm_consul   ## you can give absolute or relative path to osm_consul
```

### Inventory
Your inventory should look like below.
```hcl
[consul-leader-server]
server ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-servers]
cluster-server1 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
cluster-server2 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
cluster-server3 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-clients]
client ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-amd]
consul-server ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
```

Tags
----
Below tags are assigned to the modules.
* consul-leader-server :  Modules with this tag required for creating leader of consul-cluster.
* consul-server        :  Modules with this tag required for creating member(server) of consul-cluster.
* consul-client        :  Modules with this tag required for adding consul client with the consul cluster.
* consul-amd           :  Modules with this tag required to register or deregister services with local consul client.

Variables/vars
-----------------------
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

Variables/defaults
-----------------------

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

Future changes
----------------
* TLS encryption for RPC protocol

References
-----------
* https://learn.hashicorp.com/consul/datacenter-deploy/deployment-guide

Contributor
-----------------------
Shatrujeet