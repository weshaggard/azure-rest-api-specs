# fusion

> see https://aka.ms/autorest

## Configuration

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: 2022-06-01-preview
```

### Supported API Versions

```yaml $(tag) == '2021-02-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-01-preview/fusionGroups.json
```

```yaml $(tag) == '2021-05-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-05-01-preview/fusionGroups.json
  - Wandisco.Fusion/preview/2021-05-01-preview/migrators.json
  - Wandisco.Fusion/preview/2021-05-01-preview/operations.json
  - Wandisco.Fusion/preview/2021-05-01-preview/commonTypes.json
```

```yaml $(tag) == '2021-11-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-11-01-preview/commonTypes.json
  - Wandisco.Fusion/preview/2021-11-01-preview/migrators.json
  - Wandisco.Fusion/preview/2021-11-01-preview/operations.json
```

```yaml $(tag) == '2022-01-01-preview'
input-file:
  - Wandisco.Fusion/preview/2022-01-01-preview/commonTypes.json
  - Wandisco.Fusion/preview/2022-01-01-preview/migrators.json
  - Wandisco.Fusion/preview/2022-01-01-preview/operations.json
```

```yaml $(tag) == '2022-06-01-preview'
input-file:
  - Wandisco.Fusion/preview/2022-06-01-preview/commonTypes.json
  - Wandisco.Fusion/preview/2022-06-01-preview/migrators.json
  - Wandisco.Fusion/preview/2022-06-01-preview/operations.json
```

## Language specific configurations

### python

```yaml $(python)
no-namespace-folders: true
azure-arm: true
clear-output-folder: true
```

### java
```yaml $(java)
azure-arm: true
namespace: com.wandisco.frp.api.client
```

```yaml $(tag) == '2021-02-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-01-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-02-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-02-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-03-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-03-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-04-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-04-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-05-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-05-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-06-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-06-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-07-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-07-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-08-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-08-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-09-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-09-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-10-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-10-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-11-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-11-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-12-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-12-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-13-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-13-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-14-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-14-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-15-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-15-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-16-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-16-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-17-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-17-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-18-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-18-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-19-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-19-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-20-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-20-preview/fusionGroups.json
```

```yaml $(tag) == '2021-05-01-preview'
input-file:
```

```yaml $(tag) == '2021-05-02-preview'
input-file:
```

```yaml $(tag) == '2021-05-03-preview'
input-file:
```

```yaml $(tag) == '2021-05-04-preview'
input-file:
```

```yaml $(tag) == '2021-05-05-preview'
input-file:
```

```yaml $(tag) == '2021-05-06-preview'
input-file:
```

```yaml $(tag) == '2021-05-07-preview'
input-file:
```

```yaml $(tag) == '2021-05-08-preview'
input-file:
```

```yaml $(tag) == '2021-05-09-preview'
input-file:
```

```yaml $(tag) == '2021-05-10-preview'
input-file:
```

```yaml $(tag) == '2021-05-11-preview'
input-file:
```

```yaml $(tag) == '2021-05-12-preview'
input-file:
```

```yaml $(tag) == '2021-05-13-preview'
input-file:
```

```yaml $(tag) == '2021-05-14-preview'
input-file:
```

```yaml $(tag) == '2021-05-15-preview'
input-file:
```

```yaml $(tag) == '2021-05-16-preview'
input-file:
```

```yaml $(tag) == '2021-05-17-preview'
input-file:
```

```yaml $(tag) == '2021-05-18-preview'
input-file:
```

```yaml $(tag) == '2021-05-19-preview'
input-file:
```

```yaml $(tag) == '2021-05-20-preview'
input-file:
```

```yaml $(tag) == '2021-11-01-preview'
input-file:
```

```yaml $(tag) == '2021-11-02-preview'
input-file:
```

```yaml $(tag) == '2021-11-03-preview'
input-file:
```

```yaml $(tag) == '2021-11-04-preview'
input-file:
```

```yaml $(tag) == '2021-11-05-preview'
input-file:
```

```yaml $(tag) == '2021-11-06-preview'
input-file:
```

```yaml $(tag) == '2021-11-07-preview'
input-file:
```

```yaml $(tag) == '2021-11-08-preview'
input-file:
```

```yaml $(tag) == '2021-11-09-preview'
input-file:
```

```yaml $(tag) == '2021-11-10-preview'
input-file:
```

```yaml $(tag) == '2021-11-11-preview'
input-file:
```

```yaml $(tag) == '2021-11-12-preview'
input-file:
```

```yaml $(tag) == '2021-11-13-preview'
input-file:
```

```yaml $(tag) == '2021-11-14-preview'
input-file:
```

```yaml $(tag) == '2021-11-15-preview'
input-file:
```

```yaml $(tag) == '2021-11-16-preview'
input-file:
```

```yaml $(tag) == '2021-11-17-preview'
input-file:
```

```yaml $(tag) == '2021-11-18-preview'
input-file:
```

```yaml $(tag) == '2021-11-19-preview'
input-file:
```

```yaml $(tag) == '2021-11-20-preview'
input-file:
```

```yaml $(tag) == '2022-01-01-preview'
input-file:
```

```yaml $(tag) == '2022-01-02-preview'
input-file:
```

```yaml $(tag) == '2022-01-03-preview'
input-file:
```

```yaml $(tag) == '2022-01-04-preview'
input-file:
```

```yaml $(tag) == '2022-01-05-preview'
input-file:
```

```yaml $(tag) == '2022-01-06-preview'
input-file:
```

```yaml $(tag) == '2022-01-07-preview'
input-file:
```

```yaml $(tag) == '2022-01-08-preview'
input-file:
```

```yaml $(tag) == '2022-01-09-preview'
input-file:
```

```yaml $(tag) == '2022-01-10-preview'
input-file:
```

```yaml $(tag) == '2022-01-11-preview'
input-file:
```

```yaml $(tag) == '2022-01-12-preview'
input-file:
```

```yaml $(tag) == '2022-01-13-preview'
input-file:
```

```yaml $(tag) == '2022-01-14-preview'
input-file:
```

```yaml $(tag) == '2022-01-15-preview'
input-file:
```

```yaml $(tag) == '2022-01-16-preview'
input-file:
```

```yaml $(tag) == '2022-01-17-preview'
input-file:
```

```yaml $(tag) == '2022-01-18-preview'
input-file:
```

```yaml $(tag) == '2022-01-19-preview'
input-file:
```

```yaml $(tag) == '2022-01-20-preview'
input-file:
```

```yaml $(tag) == '2022-06-01-preview'
input-file:
```

```yaml $(tag) == '2022-06-02-preview'
input-file:
```

```yaml $(tag) == '2022-06-03-preview'
input-file:
```

```yaml $(tag) == '2022-06-04-preview'
input-file:
```

```yaml $(tag) == '2022-06-05-preview'
input-file:
```

```yaml $(tag) == '2022-06-06-preview'
input-file:
```

```yaml $(tag) == '2022-06-07-preview'
input-file:
```

```yaml $(tag) == '2022-06-08-preview'
input-file:
```

```yaml $(tag) == '2022-06-09-preview'
input-file:
```

```yaml $(tag) == '2022-06-10-preview'
input-file:
```

```yaml $(tag) == '2022-06-11-preview'
input-file:
```

```yaml $(tag) == '2022-06-12-preview'
input-file:
```

```yaml $(tag) == '2022-06-13-preview'
input-file:
```

```yaml $(tag) == '2022-06-14-preview'
input-file:
```

```yaml $(tag) == '2022-06-15-preview'
input-file:
```

```yaml $(tag) == '2022-06-16-preview'
input-file:
```

```yaml $(tag) == '2022-06-17-preview'
input-file:
```

```yaml $(tag) == '2022-06-18-preview'
input-file:
```

```yaml $(tag) == '2022-06-19-preview'
input-file:
```

```yaml $(tag) == '2022-06-20-preview'
input-file:
```
