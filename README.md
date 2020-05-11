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
### cluster.yml
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
### client.yml
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
### server.yml
-   hosts: [consul-servers]
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        - import_role:
            name: ./osm_consul   ## you can give absolute or relative path to osm_consul
```
### For Adding Modifying and Deleting services to local consul agent ###
```hcl
ansible-playbook -i inventory amd.yml -t consul-amd --ssh-common-args='-o StrictHostKeyChecking=no'
```
```hcl
---
### amd.yml
-   hosts: [consul-amd]
    become: yes
    become_user: root
    gather_facts: yes
    tasks:
        - import_role:
            name: ./osm_consul
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

[consul-amd]
server ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
---
```
