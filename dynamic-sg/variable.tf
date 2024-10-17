# Variable for ingress ports
variable "ingress_ports" {
  description = "List of ingress ports to allow"
  type        = list(number)
}
