## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_arcopenstack
package-version: 2021-05-31-private-preview
azure-arm: true
```

### Tag: package-2021-05-31-private-preview and ruby

These settings apply only when `--tag=package-2021-05-31-private-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-05-31-private-preview' && $(ruby)
namespace: Microsoft.ConnectedOpenStack
output-folder: $(ruby-sdks-folder)/arcopenstack
```
