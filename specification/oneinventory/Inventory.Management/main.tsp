import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/azureHost.tsp";
import "./models/cluster.tsp";
import "./models/datacenter.tsp";
import "./models/subscriptioninternalproperty.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Microsoft Inventory",
  version: "2023-09-20-preview",
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
  getAzureHost is ArmLocResourceRead<AzureHostResource, BaseParameters<AzureHostResource> & LocationParameter>;
  listAzureHosts is ArmLocResourceListByParent<AzureHostResource, LocationCollectionParameters<AzureHostResource>>;
}

@tenantResource
model ClusterResource is ProxyResource<ClusterProperties> {
  @pattern("[a-zA-Z0-9]+[-_]*")
  @key("clusterName")
  @segment("physicalClusters")
  @doc("Cluster")
  @path
  name: string;
}

@armResourceOperations
interface Clusters {
  getCluster is ArmLocResourceRead<ClusterResource>;
  listClusters is ArmLocResourceListByParent<ClusterResource>;
}

@tenantResource
model DatacenterResource is ProxyResource<DatacenterProperties> {
  @pattern("[a-zA-Z0-9]+[-_]*")
  @key("datacenterName")
  @segment("physicalDatacenters")
  @doc("Datacenter")
  @path
  name: string;
}

@armResourceOperations
interface Datacenters {
  getDatacenter is ArmLocResourceRead<DatacenterResource>;
  listDatacenters is ArmLocResourceListByParent<DatacenterResource>;
}

model SubscriptionInternalPropertyResource is ExtensionResource<SubscriptionInternalProperties> {
  @segment("subscriptionInternalProperties")
  @doc("Subscription billing properties")
  @key("subscriptionInternalPropertyName")
  @path
  name: string = "default";
}

@armResourceOperations
interface SubscriptionInternalPropertyResources {
  @doc("Gets Subscription's internal properties.")
  getSubscriptionInternalPropertyResource is ArmResourceRead<SubscriptionInternalPropertyResource>;
}

interface Operations extends Azure.ResourceManager.Operations {}

model LocationInstanceParameters<T extends ArmResource> {
  ...ApiVersionParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...KeysOf<T>;
}
model LocationCollectionParameters<T extends ArmResource> {
  ...ApiVersionParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...ParentKeysOf<T>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "Template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Operation Template types must use PascalCase"
/**
 * A resource list operation, at the scope of the resource's parent
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 * @template TParentName Optional. The name of the parent resource
 * @template TParentFriendlyName Optional. The friendly name of the parent resource
 */
@autoRoute
@get
@listsResource(TResource)
@segmentOf(TResource)
@armRenameListByOperation(TResource, TParentName, TParentFriendlyName) // This must come before @armResourceList!
@armResourceList(TResource)
op ArmLocResourceListByParent<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>,
  TParentName extends valueof string = "",
  TParentFriendlyName extends valueof string = ""
>(
  ...LocationCollectionParameters<TResource>,
): ArmResponse<ResourceListResult<TResource>> | ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "Template"
/// Templates
/**
 * A resource GET operation
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
@autoRoute
@doc("Get a {name}", TResource)
@get
@armResourceRead(TResource)
op ArmLocResourceRead<TResource extends ArmResource, TBaseParameters = BaseParameters<TResource>>(
  ...LocationInstanceParameters<TResource>,
): ArmResponse<TResource> | ErrorResponse;
