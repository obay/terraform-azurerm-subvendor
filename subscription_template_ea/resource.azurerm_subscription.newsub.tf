resource "azurerm_subscription" "newsub" {
  subscription_name = var.subscription_name
  billing_scope_id  = data.azurerm_billing_mca_account_scope.billing_scope.id
  workload          = var.workload
}
