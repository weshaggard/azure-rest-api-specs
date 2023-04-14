import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.MobilePacketCoreNetworkFunction;

@doc("AO5GC Basic Network Function")
model NetworkFunctionResource
  is TrackedResource<NetworkFunctionResourceProperties> {
  @doc("The name of the network function")
  @key("networkFunctionName")
  @segment("networkFunctions")
  @path
  name: string;
}

@doc("Network Function Properties.")
model NetworkFunctionResourceProperties {
  @doc("SKU")
  @visibility("create", "read")
  sku: SkuValues;

  @doc("State of the network function")
  @visibility("read")
  networkFunctionState: NetworkFunctionState;

  @doc("User provided description")
  userDescription?: string;

  @doc("Billing information")
  @visibility("read")
  billing: Billing;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Billing information")
model Billing {
  @doc("Billing state")
  state: EnableDisable;

  @doc("Billing rate $/hr")
  rate?: float32;
}

@armResourceOperations(NetworkFunctionResource)
interface NetworkFunctions
  extends TrackedResourceOperations<NetworkFunctionResource, NetworkFunctionResourceProperties> {}

@doc("Available SKUs")
enum SkuValues {
  AMF,
  SMF,
  UPF,
  SaeGw
}

@doc("Enable/Disable enumerations")
enum EnableDisable {
  Enabled,
  Disabled
}

@doc("Network Function State enumerations")
enum NetworkFunctionState {
  Commissioned,
  Active,
  Decommissioned,
  Inactive
}


@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}