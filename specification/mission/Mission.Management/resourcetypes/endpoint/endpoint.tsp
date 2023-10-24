import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../virtualEnclave/virtualenclave.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Endpoint Protocol Enum")
enum EndpointProtocol {
  @doc("Protocol of Type ANY")
  ANY,

  @doc("Protocol of Type TCP")
  TCP,

  @doc("Protocol of Type UDP")
  UDP,

  @doc("Protocol of Type ICMP")
  ICMP,

  @doc("Protocol of Type ESP")
  ESP,

  @doc("Protocol of Type AH")
  AH,
}

@doc("EndpointRule Properties")
model EndpointRule {
  @doc("Endpoint Rule Id.")
  id?: string;

  @doc("IP Address. Can include multiple CIDR/IP Addresses separated by commas.")
  address?: string;

  @doc("Port. Can include multiple ports separated by commas or a range indicated by a hyphen.")
  port?: string;

  @doc("Protocol. Options specified by Endpoint Protocol Enum.")
  protocol?: EndpointProtocol;
}

@doc("Endpoint Resource properties")
model EndpointProperties {
  @doc("Endpoint Description.")
  description?: string;

  @doc("Endpoint Rule Collection.")
  endpointRuleCollection?: EndpointRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
