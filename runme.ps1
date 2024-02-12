.\create-subscription_mca.ps1 `
  -SubscriptionName "Test Subscription" `
  -PrincipalRoles @{
    "obay@mytenant.com"="Contributor";
    "anthony@mytenant.com"="Reader"
  } `
  -ManagementGroupName "Sandbox"
  #   -BillingAccountName "00000000-0000-0000-0000-000000000000:00000000-0000-0000-0000-000000000000_2019-05-31" `
  #   -BillingProfileName "0000-0000-000-000" `
  #   -InvoiceSectionName "0000-0000-000-000" `
