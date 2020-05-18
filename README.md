# osm_consul

This repo consists of Ansible role to:

    1. create consul-cluster with any number of nodes

    2. add client to existing consul-cluster

    3. add server to existing consul-cluster
    
    4. add, modify, and delete services under local consul-client

Usage
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
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