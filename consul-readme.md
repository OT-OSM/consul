## Table of Contents

1. [Overview](#1-overview)  
2. [Supported Operating Systems](#2-supported-operating-systems)  
3. [Prerequisites & Known Limitations](#3-prerequisites--known-limitations)  
4. [Architecture & Core Components](#4-architecture--core-components)  
5. [Configuration Overview](#5-configuration-overview)  
6. [Installation Flow](#6-installation-flow)  
7. [Running Consul](#7-running-consul)  
8. [Validation & Testing](#8-validation--testing)  
9. [Best Practices Followed](#9-best-practices-followed)  
10. [Troubleshooting](#10-troubleshooting)  
11. [Conclusion](#11-conclusion)  
12. [References](#12-references)  
13. [Author](#13-author)  

## 1. Overview

**HashiCorp Consul** is a service networking platform that enables:

- Service Discovery  
- Service Mesh  
- Health Checking  
- Key-Value Storage  
- Secure Service-to-Service Communication  

It is widely used in distributed systems and microservices architectures to provide dynamic infrastructure management.

### Problems Consul Solves

- How do services find each other?
- How do we secure service communication?
- How do we monitor service health?
- How do we manage configuration centrally?

### Supported Environments

Consul works across:

- Virtual Machines  
- Kubernetes  
- Hybrid environments  
- Multi-cloud deployments  

---

## 2. Supported Operating Systems

Consul supports multiple operating systems:

### Linux
- Ubuntu  
- Debian  
- RHEL  
- CentOS  
- Amazon Linux  

### Other Platforms
- Windows  
- macOS  
- Kubernetes environments  
- Cloud platforms:
  - AWS  
  - Azure  
  - GCP  

> Consul is written in **Go** and distributed as a single binary.

---

## 3. Prerequisites & Known Limitations

### Prerequisites

- Network connectivity between cluster nodes  
- Minimum **3 nodes** for production cluster (recommended)  
- Proper firewall configuration (ports **8300–8600**)  
- Stable DNS or IP addressing  
- TLS certificates (for secure production environments)  

### Known Limitations

- Requires quorum for leader election  
- Performance depends on cluster size and network latency  
- Misconfigured ACLs can block cluster operations  
- Not a replacement for full configuration management tools  

---

## 4. Architecture & Core Components

Consul architecture consists of the following components:

### 4.1 Servers

- Maintain cluster state  
- Participate in **Raft consensus**  
- Handle leader election  

### 4.2 Clients (Agents)

- Run on application nodes  
- Register services  
- Perform health checks  

### 4.3 Datacenter

- Logical grouping of nodes in a specific environment  

### 4.4 Gossip Protocol

- Used for node membership  
- Handles failure detection  

### 4.5 Raft Consensus

- Provides strong consistency  
- Manages leader election among servers  

### 4.6 Key-Value Store

- Stores configuration data centrally  
- Used for dynamic application configuration  

### 4.7 Service Mesh (Connect)

- Provides secure service-to-service communication  
- Uses **mTLS (Mutual TLS)**  
- Enables zero-trust networking between services  

---



## Role Structure
```
.
├── inventory.ini
├── site.yml
└── roles/
    └── consul/
        ├── defaults/
        │   └── main.yml
        ├── files/
        │   └── read-policy.hcl
        ├── handlers/
        │   └── main.yml
        ├── meta/
        │   └── main.yml
        ├── tasks/
        │   ├── acl.yml
        │   ├── acl_policies.yml
        │   ├── acl_tokens.yml
        │   ├── config.yml
        │   ├── directories.yml
        │   ├── install.yml
        │   ├── main.yml
        │   ├── rbac.yml
        │   └── service.yml
        ├── templates/
        │   ├── consul.service.j2
        │   ├── prometheus-consul.yml.j2
        │   ├── server.hcl.j2
        │   └── policies/
        │       ├── agent-policy.hcl.j2
        │       ├── monitoring-policy.hcl.j2
        │       ├── readonly-policy.hcl.j2
        │       └── service-policy.hcl.j2
        ├── tests/
        │   └── test.yml
        └── vars/
            └── main.yml
```

## 5. Configuration Overview

Consul can be configured using:

- HCL files  
- JSON configuration files  
- Command-line flags  
- Environment variables  

### Important Configuration Parameters

| Parameter          | Description |
|-------------------|------------|
| `node_name`        | Unique node identifier |
| `bind_addr`        | Address to bind Consul to |
| `data_dir`         | Directory for Consul data |
| `server`           | Defines server or client mode (`true/false`) |
| `bootstrap_expect` | Number of servers expected for cluster formation |
| `retry_join`       | List of nodes to join cluster |
| `acl`              | Enables Access Control Lists |
| `ui_config`        | UI configuration settings |

### ACL Configuration Includes

- Enable/Disable ACLs  
- Default policies  
- Token management  
- Token persistence  

---

## 6. Installation Flow
### Step 1: Download Binary
```
wget https://releases.hashicorp.com/consul/1.17.0/consul_1.17.0_linux_amd64.zip
```

### Step 2: Unzip
```
unzip consul_1.17.0_linux_amd64.zip
```

### Step 3: Move Binary
```
sudo mv consul /usr/local/bin/
```

### Step 4: Verify Installation
```
consul --version
```

# 7. Running the Playbook
```
ansible-playbook -i inventory.ini site.yml
```

# 8. Validation & Testing
## Check Cluster Members
```
consul members
```
## Check Leader
```
consul operator raft list-peers
```
## Check Services
```
consul catalog services
```
## Access UI

Default UI URL:

```
http://<server-ip>:8500
```

# 9. Best Practices Followed

- Always use minimum 3 server nodes

- Enable ACLs in production

- Use TLS encryption

- Avoid running in -dev mode in production

- Monitor health checks continuously

- Secure gossip communication

- Use proper token management

# 10. Troubleshooting
## Consul Not Starting

- Check systemd logs

```
journalctl -u consul
```
## No Leader Elected

- Ensure minimum quorum

- Verify bootstrap_expect value

- Check network connectivity

## ACL Errors

- Verify bootstrap token

- Ensure token persistence is enabled

- Check default policy

## Node Not Joining

- Verify retry_join

- Check firewall ports

- Validate bind address

# 11. Conclusion

HashiCorp Consul is a powerful service networking solution designed for modern distributed systems.

It provides:

- Reliable service discovery

- Secure service communication

- Centralized configuration

- High availability clustering

Consul simplifies infrastructure complexity and enables scalable microservices architecture.

# 12. References


| Purpose | Link |
|---------|------|
| Consul Official Documentation | https://developer.hashicorp.com/consul/docs |
| Consul Installation Guide | https://developer.hashicorp.com/consul/docs/install |
| Consul ACL Documentation | https://developer.hashicorp.com/consul/docs/security/acl |
| Consul Service Mesh Guide | https://developer.hashicorp.com/consul/docs/connect |

# 13. Author

**Author**: Annem Anitha
**Last Updated:** 25-Feb-2026

