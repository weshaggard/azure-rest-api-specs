## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_codespaces
package-version: 2022-05-10
azure-arm: true
```

### Tag: package-2022-05-10-preview and ruby

These settings apply only when `--tag=package-2022-05-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-05-10' && $(ruby)
namespace: GitHub.Codespaces
output-folder: $(ruby-sdks-folder)/github-codespaces
```
