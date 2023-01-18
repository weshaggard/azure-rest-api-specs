# CADL for RPaaS

## Prerequisites

1. Need Node version >= 16

## Initialize

Run the initialize script

```powershell
.\initialize.ps1
```

## Emitters

To generate swagger

```powershell
npx cadl compile . --emit @azure-tools/cadl-autorest --option arm-types-path="../../../../../common-types/resource-management/v3/types.json"
```

To generate swagger implicitly use

```powershell
npx cadl compile . --option arm-types-path="../../../../../common-types/resource-management/v3/types.json"
```

## More Details

[OneNote](https://microsoftapc.sharepoint.com/teams/Liftr-PAN/Shared%20Documents/Engineering/Palo%20Alto%20Networks%20-%20Liftr/CADL.one#Compile&section-id={2C19B114-E059-43AD-84F9-E6A06A7C5264}&page-id={1F29F333-5870-4D3E-A05C-4D48EB6A347D}&end)