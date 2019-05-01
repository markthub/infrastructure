variable "name" {
  type = "string"
}

variable "aws_region" {
  type = "string"
}

variable "namespace" {
  type = "string"
}

variable "cluster_name" {
  type = "string"
}

variable "version" {
  type    = "string"
  default = "0.12.1"
}
