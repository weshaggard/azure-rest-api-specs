## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_PAN.cloudngfw
package-version: 2022-02-17-preview
azure-arm: true
```

### Tag: package-2022-02-17-preview and ruby

These settings apply only when `--tag=package-2022-02-17-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-02-17-preview' && $(ruby)
namespace: PAN.cloudngfw
output-folder: $(ruby-sdks-folder)/PAN.cloudngfw
```
