import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("Enclave Connection Resource properties")
model EnclaveConnectionProperties {
  @doc("Community Resource Id.")
  communityResourceId: CommunityResourceId;

  @doc("Source Resource Id.")
  sourceResourceId: EnclaveConnectionSourceResourceId;

  @doc("Source CIDR.")
  sourceCidr: string;

  @doc("Destination Endpoint Resource Id.")
  destinationEndpointId: DestinationEndpointResourceId;

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
