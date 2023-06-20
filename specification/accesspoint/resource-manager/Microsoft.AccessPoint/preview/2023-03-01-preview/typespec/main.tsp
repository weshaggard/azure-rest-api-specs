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

@armProviderNamespace("Microsoft.AccessPoint")
@service({
  title: "Microsoft.AccessPoint",
  version: "2023-03-01-preview",
})
@doc("Azure Access Point Management API")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AccessPoint;

interface Operations extends Azure.ResourceManager.Operations {}

@Azure.Core.lroStatus
@doc("The provisioning status of the resource")
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("An Azure Access Point Gateway")
model GatewayResource is TrackedResource<GatewayResourceProperties> {
  @doc("The name of the Gateway")
  @key("gatewayName")
  @segment("gateways")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
}

@doc("An Azure Access Point Gateway Site")
@parentResource(GatewayResource)
model SiteResource is TrackedResource<SiteResourceProperties> {
  @doc("The name of the Gateway Site")
  @key("siteName")
  @segment("sites")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
}

@doc("An Azure Access Point Gateway Subnet")
@parentResource(SiteResource)
model SubnetResource is TrackedResource<SubnetResourceProperties> {
  @doc("The name of the Gateway Subnet")
  @key("subnetName")
  @segment("subnets")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
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

@doc("Cluster Classification Levels")
enum ClassificationLevel {
  Collateral,
  Sar,
  Sci,
  SciSar,
}

@doc("Gateway Properties.")
model GatewayResourceProperties {
  @doc("The Classification Level of the Access Point infrastructure.")
  @visibility("create", "read")
  classificationLevel: ClassificationLevel;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Gateway Site Properties.")
model SiteResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Gateway Subnet Properties.")
model SubnetResourceProperties {
  @doc("The IP Range of the subnet")
  @visibility("read")
  addressPrefix?: string;

  @doc("The size of the subnet you wish to create")
  @visibility("create")
  subnetMask: int32;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

scalar GatewaySubnetId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.AccessPoint/gateways/sites/subnets",
    }
  ]>;

// This entire object must is read only
@doc("Properties of TTC")
model TtcProperties {
  @doc("The TTC device guid")
  guid: string;
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

  @doc("The id of the subnet that the Access Point is attached to")
  @visibility("create", "read")
  gatewaySubnetId: GatewaySubnetId;

  @doc("The IP address")
  @pattern("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$")
  @visibility("read")
  ipAddress?: string;

  @doc("The properties from TTC")
  @visibility("read")
  ttc?: TtcProperties;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Gateway {
  get is ArmResourceRead<GatewayResource>;
  create is ArmResourceCreateOrUpdateAsync<GatewayResource>;
  update is ArmTagsPatchSync<GatewayResource>;
  delete is ArmResourceDeleteAsync<GatewayResource>;
  listByResourceGroup is ArmResourceListByParent<GatewayResource>;
  listBySubscription is ArmListBySubscription<GatewayResource>;
}

@armResourceOperations
interface Site {
  get is ArmResourceRead<SiteResource>;
  create is ArmResourceCreateOrUpdateAsync<SiteResource>;
  update is ArmTagsPatchSync<SiteResource>;
  delete is ArmResourceDeleteAsync<SiteResource>;
  listByResourceGroup is ArmResourceListByParent<SiteResource>;
  listBySubscription is ArmListBySubscription<SiteResource>;
}

@armResourceOperations
interface Subnet {
  get is ArmResourceRead<SubnetResource>;
  create is ArmResourceCreateOrUpdateAsync<SubnetResource>;
  update is ArmTagsPatchSync<SubnetResource>;
  delete is ArmResourceDeleteAsync<SubnetResource>;
  listByResourceGroup is ArmResourceListByParent<SubnetResource>;
  listBySubscription is ArmListBySubscription<SubnetResource>;
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
