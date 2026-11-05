# linux-cloud-module02

## Module 02 â Linux, Networking and Cloud Infrastructure (Day 6ÒDay 10)

### Overview

This repository documents the completion of Module 02 for the INTERSHIP internship, using Oracle Cloud Infrastructure (OCI) as the cloud platform. The implementation demonstrates a minimal, functional, secure, economical, and reproducible cloud infrastructure setup with hands-on Linux demonstrations and service deployment.

**Three Objectives of Module 02:**
1. Deploy and configure a minimal OCI infrastructure - VM, network, and security settings using Always Free resources.
2. Demonstrate Linux fundamentals - core commands, user/permission management, process and service administration, SSH security.
3. Deploy and verify a web service - Nginx installation, HTTP accessibility, and connectivity testing.

---

## Architecture Diagram

`mermaid
graph TD
    Internet[Internet] -->|TCP 80/22| PublicIP[Public IP: 181.233.26.147/32]
    PublicIP -->|NSG allows| VM[VM.Standard.E2.1.Micro]
    VM -->|Listens on| Nginx[Nginx HTTP]
    Nginx -->|Serves| HTML[HTML: Module 02 - Linux and Cloud Infrastructure]

    classDef resource fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef service fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px;
    class Internet,PublicIP,NSG,VM,Nginx,HTML resource;
