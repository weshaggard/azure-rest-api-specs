import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";



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

@doc("Azure Host Properties")
model AzureHostProperties {
    @doc("Node Id")
    nodeId: string;

    @doc("Cluster Id")
    clusterId: string;

    @doc("Provisionsing state")
    provisioningState?: ProvisioningState;
}


@doc("Provisionsingin state enum")
enum ProvisioningState {
  Provisioning,
  Updating,
  Deleting,
  Accepted,
  Succeeded,
  Failed,
  Canceled,
}

@tenantResource
model AzureHost is ProxyResource<AzureHostProperties> {
    @key("azureHostName")
    @segment("azureHosts")
    @doc("Azure Host")
    @path
    name: string;
}

@armResourceOperations
interface AzureHosts {
    get is ArmResourceRead<AzureHost>;
} 

interface Operations extends Azure.ResourceManager.Operations {}
