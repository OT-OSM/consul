# osm_consul

This repo consists of Ansible role for Consul

ANSIBLE COMMAND TO USE
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
### For n node consul-cluster ###
```hcl
1. Firstly you will have to create a leader
ansible-playbook -i inventory cluster.yml -t consul-leader-server leader.yml --ssh-common-args='-o StrictHostKeyChecking=no'

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
```hcl
2. Then you need to join other server with leader
ansible-playbook -i inventory cluster.yml -t consul-server servers.yml --ssh-common-args='-o StrictHostKeyChecking=no'

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
ansible-playbook -i inventory client.yml -t consul-client client.yml --ssh-common-args='-o StrictHostKeyChecking=no'
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

### For Adding Modifying and Deleting services to local consul agent ###
```hcl
ansible-playbook -i inventory -t consul-amd amd.yml --ssh-common-args='-o StrictHostKeyChecking=no'
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

### Your inventory should look like below
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