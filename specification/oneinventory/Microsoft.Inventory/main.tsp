import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/azureHost.tsp";



@armProviderNamespace
@service(
    {title: "Microsoft Inventory", 
    version: "2023-08-09"
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Inventory;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@tenantResource
model AzureHostResource is ProxyResource<AzureHostProperties> {
    @key("azureHostName")
    @segment("physical_azureHosts")
    @doc("Azure Host")
    @path
    name: string;
}

@armResourceOperations
interface AzureHosts {
    get is ArmResourceRead<AzureHostResource>;
} 

interface Operations extends Azure.ResourceManager.Operations {}
