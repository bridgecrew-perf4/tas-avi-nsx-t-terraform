output "vcenter_cloud" {                                                                                                                                              
  value = avi_cloud.vcenter_cloud
}

output "vrfcontext" {
  value = avi_vrfcontext.global
}

output "virtual_service" {
  value = avi_virtualservice.http_vs
}