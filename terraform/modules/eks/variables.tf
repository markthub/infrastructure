variable "instance_type" {
  type = "string"
}

variable "prv_subnets" {
  type = "list"
}

variable "pub_subnets" {
  type = "list"
}

variable "cluster_name" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "key_name" {
  type = "string"
}

variable "tags" {
  type = "map"
}

variable "name" {
  type = "string"
}

variable "namespace" {
  type = "string"
}
