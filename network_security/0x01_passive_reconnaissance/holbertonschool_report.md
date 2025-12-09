# Holberton School Domain Reconnaissance Report

## 1. General Information
**Domain:** `holbertonschool.com`  
**Analysis Date:** December 2025  
**Search Engine:** [Shodan](https://www.shodan.io/)   
**Primary Infrastructure:** Amazon Web Services (AWS)  
**Security Posture:** Mixed (Production uses strict SSL; legacy/redirects allow HTTP).

---

## 2. IP Addresses & Hosting Providers
The infrastructure is distributed across multiple providers, with the core application logic hosted on AWS and specialized services (Blog, Support) offloaded to SaaS platforms.

### **Amazon Web Services (AWS)**
*Most application subdomains and the root domain reside here.*
* `75.2.70.75` (AWS Global Accelerator)
* `99.83.190.102` (AWS Global Accelerator)
* `35.180.27.154` (EC2 - eu-west-3)
* `52.47.143.83` (EC2 - eu-west-3)
* `54.155.19.65`
* `54.86.136.129`
* `3.248.56.152`
* `52.47.114.157`
* `13.38.216.13`
* `52.222.169.66`
* `18.202.8.75`
* `54.89.246.137`
* `34.203.198.145`
* `35.181.84.105`
* `15.236.177.62`
* `13.38.122.220`
* `143.204.194.41`

### **Cloudflare**
*Used for regional sites and proxies.*
* `104.17.201.193` (Hosting `en.fr` and `fr.webflow`)

### **Automattic (WordPress.com)**
*Hosting the official blog.*
* `192.0.78.230`

### **Zendesk**
*Hosting the customer support portal.*
* `216.198.54.2`

---

## 3. Subdomains & Technologies Identified

| Subdomain | IP Address | Tech Stack / Notes |
| :--- | :--- | :--- |
| `holbertonschool.com` | `75.2.70.75` | **AWS Global Accelerator**, Nginx (Redirects) |
| `yriry2` | `52.47.143.83` | **Nginx 1.21.6**, **Let's Encrypt**, TLS 1.3 |
| `apply` | `15.236.177.62` | **Ruby on Rails** (Inferred from assets) |
| `blog` | `192.0.78.230` | **WordPress** (Automattic) |
| `support` | `216.198.54.2` | **Zendesk** |
| `lvl2-discourse-staging`| `13.38.216.13` | **Discourse** (Forum Software) |
| `webflow` | `54.155.19.65` | **Webflow** (CMS) |
| `rails-assets` | `143.204.194.41`| **Ruby on Rails** Asset Pipeline |

---

## 4. Server Details (From Logs)
### **Server 1: Redirect Gateway**
* **IP:** `35.180.27.154`
* **OS:** Ubuntu
* **Software:** Nginx 1.18.0
* **Configuration:** Open HTTP (Port 80), redirects to `http://holbertonschool.com`.

### **Server 2: Level 2 Forum**
* **IP:** `52.47.143.83`
* **Software:** Nginx 1.21.6
* **SSL:** Let's Encrypt (E8), supports TLSv1.2 & TLSv1.3.
* **Headers:** `X-Frame-Options: SAMEORIGIN`, `X-Content-Type-Options: nosniff`.