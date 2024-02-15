data "azurerm_management_group" "management_group" {
  count = var.management_group_id != null ? 1 : 0
  name  = var.management_group_id
}
