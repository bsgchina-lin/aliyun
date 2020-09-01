resource "alicloud_vpc" "alicloud_demo_vpc" {
  name       = "alicloud_demo_vpc"
  cidr_block = "172.16.0.0/12"
}
