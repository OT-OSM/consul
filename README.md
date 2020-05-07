# osm_consul

This repo consists of Ansible role for Consul

ANSIBLE COMMAND TO USE
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
### For 3 node consul server cluster ###
```hcl
ansible-playbook -i inventory/server/inventory server.yml --ssh-common-args='-o StrictHostKeyChecking=no'
```
### For adding consul agent to consul server cluster ###
```hcl
ansible-playbook -i inventory/agent/inventory agent.yml --ssh-common-args='-o StrictHostKeyChecking=no'
```
### For Adding Modifying and Deleting services to local consul agent ###
```hcl
ansible-playbook -i inventory/amd/inventory amd.yml --ssh-common-args='-o StrictHostKeyChecking=no'
```