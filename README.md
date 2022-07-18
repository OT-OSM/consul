Ansible Role | Consul
========================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Consul is a Hashicorp service mesh solution providing a full featured control plane with service discovery, configuration, and segmentation functionality.

- **Automated setup of consul cluster for server with below features.**

**Version History**
------------------
|**Date**| **Version**| **Description**| **Changed By** |
|----------|---------|---------------|-----------------|
|**01 June 2022** | v-0.0.2 | Initial draft | Himanshi Parnami |
|**15 July 2022** | feature v-0.0.2 | Consul cluster server setup with acl and encrpytion key | Himanshi Parnami |

**Supported OS**
------------
  * Ubuntu: 20
  * Ubuntu: 18

**Dependencies**
------------
  * None 

### **FEATURES**
* Setup Consul server cluster
* Generate encryption key 
* Enabling ACL

## **Role variables**

### **Optional Variables | vars/main.yml**
----------------------------
Values required to update and modify by users are kept here.

|**Variables**| **Default Values**|**Possible Values**| **Description**|
|----------|---------|-------|---------------|
| consul_version | 1.8.4 | Consul version | Default version of consul |
| consul_data_path | /var/lib/consul | Any path | Data storage directory for consul |
| consul_datacenter | dc1 | Consul datacenter | Default consul datacenter |
| acl_enable | false | true , false | ACL enable value |
| consul_acl_default_policy | deny | allow, deny | ACL default policy  | 
| consul_keygenerate_file | /opt/consul_keygenerate | Any path |File Location for storing encrpytion key on host machine |   
| consul_acl_file | /opt/acl_token | Any path |File Location for storing acl bootstrap token on host machine |   
| local_acl_dest | /tmp/consul_acl | Any path |File Location for storing acl bootstrap token on controller machine |   
| local_key_dest | /tmp/consul_key | Any path | File Location for storing encrpytion key on controller machine |   

## **Consul encrpytion key**
Consul supports encrypting all of its network traffic.

## **Consul ACL feature** 
ACLs used to secure access to the UI, API, CLI, service communications, and agent communications. For securing datacenter configure ACLs is must.

By default acl value will be false in `acl_enable`. 
For enabling the acl feature change `acl_enable` to true.

While enabling acl you can also provide `consul_acl_default_policy` which will restrict the operations on consul based on the value before generating a token.

In this role if `acl_enable` is true it will create the bootstrap token on only one host machine and save the same on controller machine as well. 

**Example Playbook**
-------------------

```
# consul.yml
---
- hosts: consul-server
  become: true
  roles:
    - role: osm_consul
```

**Inventory**
-----------------

Your inventory should look like below.

```
[consul-server]
server1 ansible_host=ip/dns 
server2 ansible_host=ip/dns
server3 ansible_host=ip/dns 

[consul-server:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=path
```

**Usage**
-------------------
```
ansible-playbook -i inventory consul.yml
```

### **Contributors**

[himanshi_homepage]: https://github.com/himanshiparnami
[himanshi_avatar]: https://avatars.githubusercontent.com/u/101627875?s=200&v=4

**[![Himanshi Parnami][himanshi_avatar]][himanshi_homepage]<br/>[Himanshi Parnami][himanshi_homepage]** 