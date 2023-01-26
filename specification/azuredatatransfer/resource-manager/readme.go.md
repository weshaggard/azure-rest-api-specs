## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: azuredatatransfer
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2022-12-13
```

### Tag: package-preview-2022-12-13 and go

These settings apply only when `--tag=package-preview-2022-12-13 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2022-12-13' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-12-13-preview/$(namespace)
```
