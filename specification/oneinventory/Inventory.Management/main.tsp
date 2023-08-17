import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/azureHost.tsp";
import "./models/cluster.tsp";
import "./models/datacenter.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft Inventory",
  version: "2023-08-16-preview",
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
  getAzureHost is ArmResourceRead<AzureHostResource>;
  listAzureHosts is ArmResourceListByParent<AzureHostResource>;
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
  getCluster is ArmResourceRead<ClusterResource>;
  listClusters is ArmResourceListByParent<ClusterResource>;
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
  getDatacenter is ArmResourceRead<DatacenterResource>;
  listDatacenters is ArmResourceListByParent<DatacenterResource>;
}

interface Operations extends Azure.ResourceManager.Operations {}
