variable "billing_account_name" {
  type        = string
  description = "The name of the billing account"
}

variable "billing_profile_name" {
  type        = string
  description = "The name of the billing profile"
}

variable "invoice_section_name" {
  type        = string
  description = "The name of the invoice section"
}

variable "subscription_name" {
  type        = string
  description = "The name of the subscription"
}

variable "principal_roles" {
  type        = map(string)
  description = "A map of principal IDs and their corresponding roles"
}

variable "workload" {
  type        = string
  description = "The workload of the subscription"
  default     = "Production"
}

variable "management_group_id" {
  type        = string
  description = "The ID of the management group"
  default     = null
}