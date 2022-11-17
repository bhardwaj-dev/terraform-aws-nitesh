variable "projectName" {
  default = "nitesh-terra-prj"
}

variable "bucketName" {
  default = "nitesh-terra-backend"
}

variable "region" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-2 = "ami-0d5bf08bc8017c83b"
  }
}

variable "priv_key_path" {
  default = "nitesh-key"
}

variable "pub_key_path" {
  default = "nitesh-key.pub"
}

variable "username" {
  default = "ubuntu"
}

variable "myIP" {
  default = "110.235.233.138/32"
}

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  type = string
}

variable "dbuser" {
  default = "admin"
}

variable "dbname" {
  default = "accounts"
}
variable "dbpass" {
  type = string
}

variable "instance_count" {
  default = "1"
}
variable "vpc_name" {
  default = "nitesh-vpc"
}
variable "zone1" {
  default = "us-east-2a"
}
variable "zone2" {
  default = "us-east-2b"
}
variable "zone3" {
  default = "us-east-2c"
}
variable "vpc_CIDR" {
  default = "172.21.0.0/16"
}
variable "cidr_pub_sub_1" {
  default = "172.21.1.0/24"
}
variable "cidr_pub_sub_2" {
  default = "172.21.2.0/24"
}
variable "cidr_pub_sub_3" {
  default = "172.21.3.0/24"
}
variable "cidr_priv_sub_1" {
  default = "172.21.4.0/24"
}

variable "cidr_priv_sub_2" {
  default = "172.21.5.0/24"
}
variable "cidr_priv_sub_3" {
  default = "172.21.6.0/24"
}