import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

@armProviderNamespace("Microsoft.McetaapTest")
@service({
  title: "Microsoft Secure Access Resource Provider",
  version: "2023-05-24-preview",
})
@doc("Azure Access Point Management API")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.McetaapTest;

@Azure.Core.lroStatus
@doc("The provisioning status of the resource")
enum ProvisioningState {
  ...ResourceProvisioningState,
  @doc("Provisioning the resource is in progress")
  Provisioning,
  @doc("Resource is being updated")
  Updating,
  @doc("Resource is being deleted")
  Deleting,
  @doc("The change request has been accepted")
  Accepted,
}

@doc("An Azure Access Point Device Resource")
model AccessPointResource is TrackedResource<AccessPointResourceProperties> {
  @doc("The name of the Access Point")
  @key("accessPointName")
  @segment("accessPoints")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
}

@doc("Access Point Properties.")
model AccessPointResourceProperties {
  // Standard MAC address format
  // 00:00:00:00:00:00
  // lowercase, uppercase letters, 6 groups of 2 hex digits, separated by colons
  @doc("The MAC address")
  @pattern("^[a-fA-F0-9]{2}(:[a-fA-F0-9]{2}){5}$")
  @visibility("create", "read")
  macAddress: string;

  // @doc("The id of the subnet that the Access Point is attached to")
  // @visibility("create", "read")
  // gatewaySubnetId: GatewaySubnetId;

  @doc("The IP address")
  @pattern("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$")
  @visibility("read")
  ipAddress?: string;

  // @doc("The properties from TTC")
  // @visibility("read")
  // ttc?: TtcProperties;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AccessPoint {
  get is ArmResourceRead<AccessPointResource>;
  create is ArmResourceCreateOrUpdateAsync<AccessPointResource>;
  update is ArmTagsPatchSync<AccessPointResource>;
  delete is ArmResourceDeleteAsync<AccessPointResource>;
  listByResourceGroup is ArmResourceListByParent<AccessPointResource>;
  listBySubscription is ArmListBySubscription<AccessPointResource>;
}

interface Operations extends Azure.ResourceManager.Operations {}
