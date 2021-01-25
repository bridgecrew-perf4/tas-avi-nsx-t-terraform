# tas-avi-nsx-t-terraform
---
This repo contains terraform to help provision a TAS foundation on NSX-T using Avi loadbalancing + Avi global loadbalancing.

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

[insert some diagram here]
