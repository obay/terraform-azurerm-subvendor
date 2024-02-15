data "azurerm_billing_enrollment_account_scope" "billing_scope" {
  count = var.azure_account_type == "EA" ? 1 : 0
  billing_account_name    = var.billing_account_name
  enrollment_account_name = var.ea_name
}
