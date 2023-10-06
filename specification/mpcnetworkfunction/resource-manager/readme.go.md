## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Tag: package-2023-10-15 and go

These settings apply only when `--tag=package-2023-10-15 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2023-10-15' && $(go)
namespace: Microsoft.MobilePacketCore
output-folder: $(go-sdk-folder)/services/stable/$(namespace)/management/2023-10-15/$(namespace)
```

### Tag: package-2023-05-15-preview and go

These settings apply only when `--tag=package-2023-05-15-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2023-05-15-preview' && $(go)
namespace: Microsoft.MobilePacketCore
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/management/2023-05-15-preview/$(namespace)
```