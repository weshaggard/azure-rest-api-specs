import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is being deleted")
  Deleting,

  @doc("The resource create request has been accepted")
  Accepted,
}

@doc("An IPv4/IPv6 address.")
@pattern("^(?:\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}|\\[[0-9A-Fa-f:]+\\]|\\*)$")
scalar IpAddress extends string;

@doc("An IPv4/IPv6 address/prefix, or wildcard.")
@pattern("^(?:\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}(?:\\/\\d{1,2})?|\\[[0-9A-Fa-f:]+\\](?:\\/\\d{1,3})?|\\*)$")
scalar IpRule extends string;

scalar VirtualNetworkId
  extends ResourceIdentifier<[
    {
      type: "Private.GEMPrivateRP/virtualNetworks",
    }
  ]>;

scalar PublicIpAddressId
extends ResourceIdentifier<[
  {
    type: "Private.GEMPrivateRP/publicIPAddresss",
  }
]>;

scalar FirewallPolicyId
extends ResourceIdentifier<[
  {
    type: "Private.GEMPrivateRP/firewallPolicies",
  }
]>;

scalar EntryProfileId
extends ResourceIdentifier<[
  {
    type: "Private.GEMPrivateRP/globalEntryManagers/entryProfiles",
  }
]>;

scalar EntryProfileRuleId
extends ResourceIdentifier<[
  {
    type: "Private.GEMPrivateRP/globalEntryManagers/entryProfiles/entryProfileRules",
  }
]>;

scalar EntryRegionId
extends ResourceIdentifier<[
  {
    type: "Private.GEMPrivateRP/globalEntryManagers/entryRegions",
  }
]>;

scalar EntryLinkId
extends ResourceIdentifier<[
  {
    type: "Private.GEMPrivateRP/globalEntryManagers/entryLinks",
  }
]>;
