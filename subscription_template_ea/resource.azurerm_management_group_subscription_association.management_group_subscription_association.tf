resource "azurerm_management_group_subscription_association" "management_group_subscription_association" {
  count               = var.management_group_id != null ? 1 : 0
  management_group_id = data.azurerm_management_group.management_group[0].id
  subscription_id     = "/subscriptions/${azurerm_subscription.newsub.subscription_id}"
}
