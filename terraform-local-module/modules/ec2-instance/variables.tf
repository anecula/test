// Variables
variable "ami"{
  default     = ""
  description = "The AMI to use for the instance."
}

variable "instance_type" {
  default     = ""
  description = "The type of instance to start"
}

variable "instance_name" {
  default     = ""
  description = "The Name tag of the instance."
}

variable "vpc_security_group_ids" {
  default     = []
  type        = "list"
  description =  "The associated security groups in a non-default VPC."
}

variable "key_name" {
  default     = ""
  description =  "The key name to use for the instance."
}

variable "user_data" {
  default     = ""
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
}

variable "iam_instance_profile" {
  default     = ""
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
}

variable "disable_api_termination" {
  default     = "false"
  description = "If true, enables EC2 Instance Termination Protection"
}

variable "volume_size" {
  default      = ""
  description  = "The size in GB of the associated EBS volume."
}

variable "vpc" {
  default     = ""
  description = "The name of the selected VPC"
}

variable "availability_zone" {
  default     = ""
  description = "The suffix of the selected AZ"
}


variable "is_public" {
  default     = ""
  description = "Is the instance public? (true or false)"
}

variable "create_extra_volume" {
  default     = false
  description = "If set to true, create an extra EBS volume"
}

variable "extra_volume_size" {
  default     = ""
  description = "The size of the extra volume in GiBs."
}

variable "extra_volume_type" {
  default     = ""
  description = "The type of EBS volume. Can be 'standard', 'gp2', 'io1', 'sc1' or 'st1' (Default: 'standard')."
}

variable "extra_volume_name" {
  default     = ""
  description = "Name tag for the extra EBS volume"
}

variable "extra_volume_skip_destroy" {
  default     = ""
  description = "(Optional, Boolean) Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time, and instead just remove the attachment from Terraform state. This is useful when destroying an instance which has volumes created by some other means attached."
}

variable "create_eip" {
  default     = false
  description = "If set to true, create an EIP"
}
