## Terraform script to automate NSX-T paving

## Prerequisites

* NSX-T 2.4
* Transport zone configured for both uplink and overlay
* T0 Router is installed
* T0 Router uplink is configured (static route/bgp)

## Resources

* NSX-T Load Balancer for PAS
* NSX-T VIP for PAS
* NSX-T Load Balancer member pool
* NSX-T DNAT to Ops Manager
* NSX-T SNAT for PAS Internal IP space (192.168.0.0/16)
* NSX-T T1 Routers
  * Deployment
  * Infrastructure
  * Services
* NSX-T Switches/Segments
  * Deployment
  * Infrastructure
  * Services
* NSX-T IP Block (192.168.128.0/17)  

## Pave the NSX-T

* [Install Terraform](https://www.terraform.io/downloads.html)
* Install NSX-T latest plugin

  ```
  terraform init
  ```
* Configure a terraform.tfvars by referencing [example.tfvars](./example.tfvars)
* Install nsx-t resources
  ```
  terraform apply
  ```

## Teardown the infrastructure

* ```terraform destroy```
