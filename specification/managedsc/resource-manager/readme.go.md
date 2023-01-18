## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: managedsc
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-08-26-preview
  - tag: package-2023-02-01-preview
```

### Tag: package-2022-08-26-preview and go

These settings apply only when `--tag=package-2022-08-26-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-08-26-preview' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-08-26-preview/$(namespace)
```

### Tag: package-2023-02-01-preview and go

These settings apply only when `--tag=package-2023-02-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2023-02-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2023-02-01-preview/$(namespace)
```
