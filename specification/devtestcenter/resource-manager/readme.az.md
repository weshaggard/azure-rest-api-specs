## AZ

These settings apply only when `--az` is specified on the command line..

``` yaml $(az)
az:
    extensions: dtc
    namespace: azure.mgmt.dtc
    package-name: azure-mgmt-dtc
az-output-folder: $(azure-cli-extension-folder)/src/dtc
python-sdk-output-folder: "$(az-output-folder)/azext_dtc/vendored_sdks/dtc"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details