Ansible Role | Consul
========================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Consul is a Hashicorp service mesh solution providing a full featured control plane with service discovery, configuration, and segmentation functionality.It is based and built on Golang. One of the core reasons to build Consul was to maintain the services present in the distributed systems. 

 - **Automated setup of consul standalone with below features.**

**Version History**
------------------
|**Date**| **Version**| **Description**| **Changed By** |
|----------|---------|---------------|-----------------|
|**01 June 2022** | v-0.0.2 | Initial draft | Himanshi Parnami |

**Supported OS**
------------
  * Ubuntu: 20

**Dependencies**
------------
  * None 

### **FEATURES**
* Setup Standalone Consul server
* Generate encryption key  

**Variables | vars/main.yml**
----------------------------
Values required to update and modify by users are kept here.

|**Variables**| **Default Values**| **Description**|
|----------|---------|---------------|
| consul_version | 1.8.4 | Consul Version to be downloaded |
| consul_data_path | /var/lib/consul | Data storage directory for consul |
| consul_datacenter | dc1 | Name of the datacenter |
| consul_nodename | node-1 | Node name |

**Variables | defaults/main.yml**
--------------------------------

|**Variables**| **Default Values**| **Description**|
|----------|---------|---------------|
| consul_bin_path | /usr/local/bin | Location to keep consul binary. |
| consul_binary_owner | root | Owner of consul binary |
| consul_binary_group | root | Group of consul binary |
| consul_user_shell | /bin/false | Shell assigned to consul user |
| consul_owner | consul | Consul data directory owner |
| consul_group | consul | Consul data directory group |
| consul_config_dest | /etc/consul.d/config.json | Location to store consul configuration. |
| consul_service_dest | /etc/systemd/system/consul.service | Location to store consul service file |
| consul_enable_syslog | true | Enables logging to syslog | 

**Example Playbook**
-------------------

```
# consul.yml
---
- hosts: all
  become: true
  roles:
    - role: osm_consul
```

**Inventory**
-----------------

Your inventory should look like below.

```
[consul]
server1 ansible_host=ip/dns ansible_connection=ssh ansible_user=ubuntu
```

**Usage**
-------------------
```
ansible-playbook consul.yml
```

### **Contributors**

[himanshi_homepage]: https://github.com/himanshiparnami
[himanshi_avatar]: https://avatars.githubusercontent.com/u/101627875?s=200&v=4

**[![Himanshi Parnami][himanshi_avatar]][himanshi_homepage]<br/>[Himanshi Parnami][himanshi_homepage]** 