data "azurerm_billing_mca_account_scope" "billing_scope" {
  count = var.azure_account_type == "MCA" ? 1 : 0
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
}
