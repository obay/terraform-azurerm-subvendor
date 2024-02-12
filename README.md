# Terraform Module to Create New Azure Subscriptions (Landing Zones)

## Introduction

This module is used to create new Azure subscriptions. The following is what the module will do exactly:

- Create a new Azure subscription
- Assign the subscription to a specific Management Group
- Assign user(s)/groups(s) to the subscription with the provided role(s)

There are 2 modules in this repository:

- subscription_template_ea: This module is used to create a new Azure subscription under an Enterprise Agreement (EA) enrollment.
- subscription_template_mca: This module is used to create a new Azure subscription under a Microsoft Customer Agreement (MCA) enrollment.

In the future, both modules will be merged and simplified.

## Usage

Use the PowerShell script `create_subscription.ps1` to create a new subscription. The script will generate the Terraform file needed to call the Terraform module to create the subscription.

A sample usage of the `create_subscription.ps1` script is shown in the script `runme.ps1`. Simply take a look at the `runme.ps1` script to understand how to use the `create_subscription.ps1` script.

## Prermissions

To run this Terraform code, you would need the following minimum permissions:

**1. Subscription Creation:** You need permissions to create a new Azure subscription. This typically requires the Microsoft.Subscription/register/action permission at the scope of the billing account.

**2. Management Group Assignment:** You need permissions to assign the new subscription to a management group. This typically requires the Microsoft.Management/managementGroups/subscriptions/write permission at the scope of the management group.

**3. Role Assignment:** The code assigns roles to principals (users, groups, service principals) at the scope of the new subscription. This requires the Microsoft.Authorization/roleAssignments/write permission at the scope of the new subscription.

**4. Provider Registration:** If the Azure providers (like Microsoft.Management) are not already registered for the new subscription, you need the Microsoft.Subscription/register/action permission at the scope of the new subscription.

These permissions are typically held by a user with the Owner or User Access Administrator roles. Please note that the exact permissions might vary based on your specific Azure setup and the roles you have defined.

Also, keep in mind that these permissions should be granted to the principal (user, group, or service principal) that is used to run the Terraform code. If you're using a service principal, make sure it has the necessary permissions.