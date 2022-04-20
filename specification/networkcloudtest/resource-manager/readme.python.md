## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml !$(track2)                         // For track1: basic Python package information
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.networkcloudtest
  package-name: azure-mgmt-networkcloudtest
  package-version: 2021-10-21-preview
  clear-output-folder: true
```

``` yaml $(python-mode) == 'update' && !$(track2)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-networkcloudtest/azure/mgmt/networkcloudtest
```

``` yaml $(python-mode) == 'create' && !$(track2)
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-networkcloudtest
```

``` yaml $(track2)                          // For track2: basic Python package information
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-networkcloudtest
no-namespace-folders: true
package-version: 2021-10-21-preview
```

``` yaml $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/networkcloudtest/azure-mgmt-networkcloudtest/azure/mgmt/networkcloudtest
```

``` yaml $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/networkcloudtest/azure-mgmt-networkcloudtest
```
