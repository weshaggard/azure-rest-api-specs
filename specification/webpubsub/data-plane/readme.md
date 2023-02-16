# Web PubSub Service

> see https://aka.ms/autorest

This is the AutoRest configuration file for Web PubSub Service.

---

## Getting Started

To build the SDK for Web PubSub Service, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Web PubSub Service API.

```yaml
openapi-type: data-plane
tag: package-2022-11-01
```

### Suppression

```yaml
directive:
  - suppress: LROStatusCodesReturnTypeSchema
    reason: For this data plane API, it is not a long run operation and the status code indicates the results.
  - suppress: XmsExamplesRequired
    reason: There are a lot of APIs that does not have the example. While it is being worked upon disabling this to ensure that we catch and fix other violations
```

### Tag: package-2022-11-01

These settings apply only when `--tag=package-2022-11-01` is specified on the command line.

```yaml $(tag) == 'package-2022-11-01'
input-file:
  - WebPubSub/stable/2022-11-01/webpubsub.json
title: AzureMessagingWebPubSubServiceClient
```

### Tag: package-2021-10-01

These settings apply only when `--tag=package-2021-10-01` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01'
input-file:
  - WebPubSub/stable/2021-10-01/webpubsub.json
title: AzureMessagingWebPubSubServiceClient
```

### Tag: package-2021-08-01-preview

These settings apply only when `--tag=package-2021-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-08-01-preview'
input-file:
  - WebPubSub/preview/2021-08-01-preview/webpubsub.json
title: AzureMessagingWebPubSubServiceClient
```

### Tag: package-2021-05-01-preview

These settings apply only when `--tag=package-2021-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-05-01-preview'
input-file:
  - WebPubSub/preview/2021-05-01-preview/webpubsub.json
title: AzureMessagingWebPubSubServiceClient
```

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  # last generated with AutoRest.0.17.3
  azure-arm: false
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Azure.Messaging.WebPubSub
  output-folder: $(csharp-sdks-folder)/webpubsub/Azure.Messaging.WebPubSub/src/Generated
  clear-output-folder: true
```

## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

```yaml $(python)
python-mode: create
azure-arm: false
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.messaging.webpubsub
package-name: azure-messaging-webpubsubservice
package-version: 1.0.0b1
clear-output-folder: true
```

```yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/webpubsub/azure-messaging-webpubsubservice/azure/messaging/webpubsubservice
```

```yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/webpubsub/azure-messaging-webpubsubservice
```

## Multi-API/Profile support for AutoRest v3 generators

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

```yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/WebPubSub/preview/2021-05-01-preview/webpubsub.json
```

If there are files that should not be in the `all-api-versions` set,
uncomment the `exclude-file` section below and add the file paths.

```yaml $(tag) == 'all-api-versions'
#exclude-file:
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```