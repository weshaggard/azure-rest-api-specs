These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: 365ConsumptionServicesMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-365ConsumptionServices
namespace: azure.mgmt.365ConsumptionServices
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/365ConsumptionServices/azure-mgmt-365ConsumptionServices/azure/mgmt/Services
```