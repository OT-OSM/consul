# osm_consul

This repo consists of Ansible role for Consul

ANSIBLE COMMAND TO USE
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
### For 3 node consul-cluster ###
```hcl
ansible-playbook -i inventory cluster.yml -t consul-cluster --ssh-common-args='-o StrictHostKeyChecking=no'
```
```hcl
---
-   hosts: [consul-cluster]
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
---
-   hosts: [consul-clients]
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        - import_role:
            name: ./osm_consul   ## you can give absolute or relative path to osm_consul
```
### For adding consul servers to consul-cluster ###
```hcl
ansible-playbook -i inventory server.yml -t consul-server --ssh-common-args='-o StrictHostKeyChecking=no'
```
```hcl
---
-   hosts: [consul-servers]
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        - import_role:
            name: ./osm_consul   ## you can give absolute or relative path to osm_consul
```
### Your inventory should look like below
```hcl
[consul-cluster]
cluster-server1 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
cluster-server2 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
cluster-server3 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu

[consul-clients]
client ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
---

[consul-servers]
server ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
---
```
### For Adding Modifying and Deleting services to local consul agent ###
```hcl
ansible-playbook -i inventory -t consul-amd --ssh-common-args='-o StrictHostKeyChecking=no'
```