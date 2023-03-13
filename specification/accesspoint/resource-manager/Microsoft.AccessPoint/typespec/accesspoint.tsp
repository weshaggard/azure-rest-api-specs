// https://cadlplayground.z22.web.core.windows.net/cadl-azure/
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureAccessPoint")
@service({
  title: "Microsoft.AzureAccessPoint",
  version: "2023-03-01-preview",
})
@doc("Azure Access Point Management API")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureAccessPoint;

interface Operations extends Azure.ResourceManager.Operations {}

@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("Access Point Gateway")
model AccessPointGatewayResource
  is TrackedResource<AccessPointGatewayResourceProperties> {
  @doc("The name of the Gateway")
  @key("accessPointGatewayName")
  @segment("accessPointGateways")
  @path
  name: string;
}

@doc("Access Point Gateway Site")
@parentResource(AccessPointGatewayResource)
model SiteResource is TrackedResource<SiteResourceProperties> {
  @doc("The name of the Gateway Site")
  @key("siteName")
  @segment("sites")
  @path
  name: string;
}

@doc("Access Point Gateway Subnet")
@parentResource(SiteResource)
model SubnetResource is TrackedResource<SubnetResourceProperties> {
  @doc("The name of the Gateway Subnet")
  @key("subnetName")
  @segment("subnets")
  @path
  name: string;
}

@doc("Access Point Resource")
model AccessPointResource is TrackedResource<AccessPointResourceProperties> {
  @doc("The name of the Access Point")
  @key("accessPointName")
  @segment("accessPoints")
  @path
  name: string;
}

@doc("Cluster Classification Levels")
enum ClassificationLevel {
  Collateral,
  Sar,
  Sci,
  SciSar
}

@doc("Access Point Gateway Properties.")
model AccessPointGatewayResourceProperties {
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
  addressPrefix: string;

  @doc("The size of the subnet you wish to create")
  @visibility("create")
  subnetMask: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

scalar GatewaySubnetId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.AzureAccessPoint/accessPointGateways/sites/subnets",
    }
  ]>;

@doc("The Gateway Subnet the resource is attached to")
model GatewaySubnetReference {
  @doc("The id of the Gateway Subnet")
  @visibility("create", "read")
  id: GatewaySubnetId;
}

@doc("Properties of TTC")
model TtcProperties {
  @doc("The TTC device guid")
  @visibility("read")
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

  @doc("The subnet the Access Point is attached to")
  @visibility("create", "read")
  gatewaySubnet: GatewaySubnetReference;

  @doc("The IP address")
  @pattern("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$")
  @visibility("read")
  ipAddress: string;

  @doc("The properties from TTC")
  @visibility("read")
  ttc: TtcProperties;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Gateway {
  get is ArmResourceRead<AccessPointGatewayResource>;
  create is ArmResourceCreateOrUpdateAsync<AccessPointGatewayResource>;
  update is ArmTagsPatchSync<AccessPointGatewayResource>;
  delete is ArmResourceDeleteAsync<AccessPointGatewayResource>;
  listByResourceGroup is ArmResourceListByParent<AccessPointGatewayResource>;
  listBySubscription is ArmListBySubscription<AccessPointGatewayResource>;
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
