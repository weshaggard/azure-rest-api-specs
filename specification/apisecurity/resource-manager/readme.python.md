## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python) && !$(track2)
python: 
    azure-arm: true
    license-header: MICROSOFT_MIT_NO_VERSION
    package-name: azure-mgmt-apisecurity
    no-namespace-folders: true
    package-version: 1.0.0b1
```

``` yaml $(python-mode) == 'update' && !$(track2)
python:
    output-folder: $(python-sdks-folder)/apisecurity/azure-mgmt-apisecurity/azure/mgmt/apisecurity
```
``` yaml $(python-mode) == 'create' && !$(track2)
python:
    basic-setup-py: true
    output-folder: $(python-sdks-folder)/apisecurity/azure-mgmt-apisecurity
```

``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-apisecurity
no-namespace-folders: true
```

``` yaml $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/apisecurity/azure-mgmt-apisecurity/azure/mgmt/apisecurity
```

``` yaml $(python-mode) == 'create' && $(track2)
package-version: 1.0.0b1
basic-setup-py: true
output-folder: $(python-sdks-folder)/apisecurity/azure-mgmt-apisecurity
```