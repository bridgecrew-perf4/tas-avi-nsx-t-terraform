# tas-avi-nsx-t-terraform
---
This repo contains terraform to help provision a TAS foundation on NSX-T using Avi loadbalancing + Avi global loadbalancing.

## Using
Using the avi terraform provider with terraform 0.14 requires you to build the provider manually and move it to a specific local directory.  The steps I took were:
```
git clone git@github.com:avinetworks/terraform-provider-avi.git
cd terraform-provider-avi
make
mkdir -p ~/.terraform.d/plugins/avinetworks.vmware.com/avinetworks/avi/20.1.2
mv ~/go/bin/terraform-provider-avi ~/.terraform.d/plugins/avinetworks.vmware.com/avinetworks/avi/20.1.2
```

## Pre-requisites
1. vSphere environment w/ NSX-T installed
2. t0-router (legacy) created + BGP peered w/ upstream router
3. BGP peers created for Avi SEs on a t0-connected logical switch

## What it creates
1. TAS Infrastructure, Deployment, and Services T1s + logical switches, w/ outbound SNATs
2. Inbound DNAT to OpsMgr on Infrastructure network
3. IP-Pool / IP-Block for NCP tile to use for per-org outbound SNAT
4. Avi Virtual Service + pool + health monitor for inbound loadbalancing to gorouters
5. Avi Virtual Service for global DNS servicing


![Image](https://github.com/wbean1/tas-avi-nsx-t-terraform/blob/main/image.png?raw=true)
