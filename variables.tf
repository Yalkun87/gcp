variable "nginx" {
  type        = string
  description = "nginx web server"
}
variable "machine_type" {
  default = "custom-1-3584"
  description = "Machine with 1 VCPU and 3.5GB RAM"
}
variable "disk_type" {
  default = "pd-ssd"
}

variable "disk_size" {
  default = "35"
}
variable "disk_image" {
  default = "debian-cloud/debian-10"
}
