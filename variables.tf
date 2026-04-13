variable "namespace" {
  type = string
  default = "default"
}

variable "name" {
  type = string
}


variable "image" {
  type = string
}


variable "container-ports" {
  type = list(number)
  default = [ 80 ]
}

variable "svc-port" {
  type = number
  default = 80
}