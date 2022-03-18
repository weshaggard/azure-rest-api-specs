## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: networkcloud
    namespace: azure.mgmt.networkcloud
    package-name: azure-mgmt-networkcloud
az-output-folder: $(azure-cli-extension-folder)/src/networkcloud
python-sdk-output-folder: "$(az-output-folder)/azext_networkcloud/vendored_sdks/networkcloud"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
