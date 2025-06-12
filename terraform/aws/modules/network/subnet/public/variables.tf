variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "public_route_map" {
  type = map(object({
    cidr_block         = string
    gateway_id         = string
    nat_gateway_id     = string
    vpc_endpoint_id    = string
    transit_gateway_id = string
  }))
}

variable "vpc_id" {
  type = string
}
