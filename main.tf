resource "azurerm_management_group" "main" {
  for_each                   = local.management_groups
  name                       = "mg-${each.key}"
  parent_management_group_id = each.value == "." ? data.azurerm_management_group.root.id : azurerm_management_group.main[each.value].id
}
