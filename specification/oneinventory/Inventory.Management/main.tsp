import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/azureHost.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(
    {title: "Microsoft Inventory", 
    version: "2023-08-09-preview"
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Inventory;

@tenantResource
model AzureHostResource is ProxyResource<AzureHostProperties> {
    @pattern("[a-zA-Z0-9]+[-]*")
    @key("azureHostName")
    @segment("physicalAzureHosts")
    @doc("Azure Host")
    @path
    name: string;
}

@armResourceOperations
interface AzureHosts {
    get is ArmResourceRead<AzureHostResource>;
    listByParent is ArmResourceListByParent<AzureHostResource>;
} 

interface Operations extends Azure.ResourceManager.Operations {}
