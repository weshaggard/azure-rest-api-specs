import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using OpenAPI;

namespace Microsoft.MobilePacketCore;

@doc("Azure for Operators 5G Core Cluster Resource")
@resource("clusters")
model ClusterResource is TrackedResource<ClusterResourceProperties> {
  @doc("The name of the Cluster")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("clusterName")
  @path
  @segment("clusters")
  @visibility("create", "read")
  name: string;
}

@doc("Cluster Properties.")
model ClusterResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Mobile Core Scaling Unit SKU")
  @visibility("create", "read")
  mobileCoreScalingUnitSku: MobileCoreScalingUnitSku;

  @doc("Mobile Core Scaling Units (MCSU)")
  @visibility("read")
  actualMobileCoreScalingUnits?: float32;

  @doc("Unity Cloud Release Version.  This is applied to all running workloads in this cluster")
  unityCloudRelease: UnityCloudRelease;
}

@armResourceOperations(ClusterResource)
interface Clusters {
  get is ArmResourceRead<ClusterResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<ClusterResource>;
  updateTags is ArmTagsPatchSync<ClusterResource>;
  delete is ArmResourceDeleteSync<ClusterResource>;
  listByResourceGroup is ArmResourceListByParent<ClusterResource>;
  listBySubscription is ArmListBySubscription<ClusterResource>;
}
