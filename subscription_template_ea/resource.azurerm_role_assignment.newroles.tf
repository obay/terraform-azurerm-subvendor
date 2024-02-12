resource "azurerm_role_assignment" "newroles" {
  for_each = var.principal_roles

  scope                = "/subscriptions/${azurerm_subscription.newsub.subscription_id}"
  role_definition_name = each.value
  principal_id         = each.key
}