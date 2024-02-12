param (
    [string]$SubscriptionName,
    [Hashtable]$PrincipalRoles,
    [string]$BillingAccountName,
    [string]$BillingProfileName,
    [string]$InvoiceSectionName,
    [string]$workload = "Production",
    [string]$ManagementGroupName
)

function Show-Usage {
    Write-Host "Usage: .\create-subscription.ps1 -SubscriptionName <SubscriptionName> -PrincipalRoles <PrincipalRoles> [-BillingAccountName <BillingAccountName>] [-BillingProfileName <BillingProfileName>] [-InvoiceSectionName <InvoiceSectionName>] [-ManagementGroupName <ManagementGroupName>]"
    exit
}

# Check for mandatory parameters
if (-not $SubscriptionName -or $PrincipalRoles.Count -eq 0) {
    Show-Usage
}

# Initialize the content variable for the tf file
$tfContent = @()

# Resolve each principal name to their ID and role
$principalRolesResolved = @{}
foreach ($principal in $PrincipalRoles.GetEnumerator()) {
    $principalName = $principal.Name
    $role = $principal.Value
    $principalId = $null
    # Attempt to find the principal ID
    $group = Get-AzADGroup -DisplayName $principalName
    if ($group) {
        $principalId = $group.Id
    }
    else {
        $user = Get-AzADUser -UserPrincipalName $principalName
        if ($user) {
            $principalId = $user.Id
        }
    }

    if (-not $principalId) {
        throw "PrincipalName '$principalName' does not match any users or groups."
    }

    $principalRolesResolved[$principalId] = $role
}

# Attempt to resolve the Management Group ID from the Management Group Name
$managementGroupId = $null
if ($ManagementGroupName) {
    $managementGroup = Get-AzManagementGroup | Where-Object DisplayName -eq $ManagementGroupName
    if ($managementGroup) {
        $managementGroupId = $managementGroup.name
    }
    else {
        throw "ManagementGroupName '$ManagementGroupName' does not match any management groups."
    }
}

# Ensure SubscriptionName is all lowercase and remove spaces or special characters
$SubscriptionNameSanitized = ($SubscriptionName -replace '[^\w-]', '').ToLower()

# Construct moduleName using the sanitized and formatted SubscriptionName
$moduleName = $SubscriptionNameSanitized + "_subscription"
$tfContent += "module `"$moduleName`" {"
$tfContent += "  source = `"./subscription_template_mca`""

# Assign the parameters including workload
$tfContent += "  subscription_name = `"$SubscriptionName`""

# Construct the principal_roles block
$principalRolesBlock = ($principalRolesResolved.GetEnumerator() | ForEach-Object {
    "`"$($_.Key)`" = `"$($_.Value)`""
}) -join "`n"


$tfContent += "  principal_roles = { 
    $principalRolesBlock 
}"

$tfContent += "  workload = `"$workload`""


# Check if optional parameters are provided, else retrieve from command line
if (-not $BillingAccountName) {
    $BILLING_ACCOUNT = az billing account list | ConvertFrom-Json
    $BillingAccountName = $BILLING_ACCOUNT[0].name
}
$tfContent += "  billing_account_name = `"$BillingAccountName`""

if (-not $BillingProfileName) {
    $BillingProfile = az billing profile list --account-name $BillingAccountName | ConvertFrom-Json
    $BillingProfileName = $BillingProfile[0].name
}
$tfContent += "  billing_profile_name = `"$BillingProfileName`""

if (-not $InvoiceSectionName) {
    $InvoiceSection = az billing invoice section list --account-name $BillingAccountName --profile-name $BillingProfileName | ConvertFrom-Json
    $InvoiceSectionName = $InvoiceSection[0].name
}
$tfContent += "  invoice_section_name = `"$InvoiceSectionName`""

# Add management group name to TF content if provided
if ($ManagementGroupName) {
    $tfContent += "  management_group_id = `"$managementGroupId`""
}

# Close module block
$tfContent += "}"

# Write the Terraform content to a .tf file with dynamic name based on subscription name
$filename = "module_" + $SubscriptionName + "_subscription.tf"
$tfContent | Out-File -FilePath ./$filename

# Optionally format the terraform files
terraform fmt

# Output completion message
Write-Output "$filename updated."

# git add $filename
# git commit -m "Added $filename"
# git push