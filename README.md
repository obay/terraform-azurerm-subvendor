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
