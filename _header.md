# terraform-azurerm-avm-res-app-managedenvironment

This is a repo for Container Apps Managed Environments in the style of Azure Verified Modules (AVM), it is an 'unofficial' example that has been used for learning AVM.

Note this uses the AZAPI provider because of support missing within the AzureRM provider for [workload profiles](https://github.com/hashicorp/terraform-provider-azurerm/issues/21747).

Once required functionality is available within AzureRM, [azapi2azurerm](https://github.com/Azure/azapi2azurerm) can be used to convert this code.

This project includes [examples](./examples/) showing default settings and a consumption-based workload profile with vnet integration.

Whilst attributes have been added to support custom domain names, Dapr & certificates this has not been tested.  Functionality is required to add support for environment storage (Azure Files).

To get started:

1. Set up a GitHub repo environment called `test`.
1. Configure environment protection rule to ensure that approval is required before deploying to this environment.
1. Create a user-assigned managed identity in your test subscription.
1. Create a role assignment for the managed identity on your test subscription, use the minimum required role.
1. Configure federated identity credentials on the user assigned managed identity. Use the GitHub environment.
1. Create the following environment secrets on the `test` environment:
   1. AZURE_CLIENT_ID
   1. AZURE_TENANT_ID
   1. AZURE_SUBSCRIPTION_ID
