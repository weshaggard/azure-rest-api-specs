# applicationassessment

> see https://aka.ms/autorest

This is the AutoRest configuration file for applicationassessment.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the applicationassessment.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2021-08-01-privatepreview
```

### Tag: package-2020-09-01-privatepreview

These settings apply only when `--tag=package-2020-09-01-privatepreview` is specified on the command line.

```yaml $(tag) == 'package-2020-09-01-privatepreview'
input-file:
  - Microsoft.AppAssessment/preview/2020-09-01-privatepreview/operations.json
  - Microsoft.AppAssessment/preview/2020-09-01-privatepreview/osVersions.json
  - Microsoft.AppAssessment/preview/2020-09-01-privatepreview/migrateProjects.json
  - Microsoft.AppAssessment/preview/2020-09-01-privatepreview/migrateProjectSite.json
  - Microsoft.AppAssessment/preview/2020-09-01-privatepreview/migrateAssessments.json
  - Microsoft.AppAssessment/preview/2020-09-01-privatepreview/migrateAssessmentsApplications.json
  - Microsoft.AppAssessment/preview/2020-09-01-privatepreview/migrateAssessmentsMachines.json
  - Microsoft.AppAssessment/preview/2020-09-01-privatepreview/migrateAssessmentsAnnotations.json
```

### Tag: package-2021-08-01-privatepreview

These settings apply only when `--tag=package-2021-08-01-privatepreview` is specified on the command line.

```yaml $(tag) == 'package-2021-08-01-privatepreview'
input-file:
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/operations.json
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/osVersions.json
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/migrateProjects.json
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/migrateProjectSite.json
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/machineToAssessGroups.json
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/migrateAssessments.json
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/migrateAssessmentsApplications.json
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/migrateAssessmentsMachines.json
  - Microsoft.AppAssessment/preview/2021-08-01-privatepreview/migrateAssessmentsAnnotations.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_applicationassessment']
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)