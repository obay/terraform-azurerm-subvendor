resource "azurerm_subscription" "newsub" {
  subscription_name = var.subscription_name
  billing_scope_id  = var.azure_account_type == "MCA" ? data.azurerm_billing_mca_account_scope.billing_scope[0].id : var.azure_account_type == "EA" ? data.azurerm_billing_enrollment_account_scope.billing_scope[0].id : null
  workload          = var.workload

  tags = var.tags
}
