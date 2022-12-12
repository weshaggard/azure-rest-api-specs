## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_mobileCore
package-version: 2021-06-15-preview
azure-arm: true
```

### Tag: package-2021-06-15-preview and ruby

These settings apply only when `--tag=package-2021-06-15-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-06-15-preview' && $(ruby)
namespace: Microsoft.MobileCore
output-folder: $(ruby-sdks-folder)/mobileCore
```