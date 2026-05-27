# -----------------------------------------------------------------------------
# Module-Specific Variables
# -----------------------------------------------------------------------------

variable "scope" {
  type        = string
  description = "Scope of the IP set. Valid values: REGIONAL, CLOUDFRONT."
  validation {
    condition     = contains(["REGIONAL", "CLOUDFRONT"], var.scope)
    error_message = "Scope must be REGIONAL or CLOUDFRONT."
  }
}

variable "description" {
  type        = string
  description = "Description of the IP set."
  default     = ""
}

variable "ip_address_version" {
  type        = string
  description = "IP address version. Valid values: IPV4, IPV6."
  default     = "IPV4"
  validation {
    condition     = contains(["IPV4", "IPV6"], var.ip_address_version)
    error_message = "Must be IPV4 or IPV6."
  }
}

variable "addresses" {
  type        = list(string)
  description = "List of IP addresses or CIDR blocks."
  default     = []
}
