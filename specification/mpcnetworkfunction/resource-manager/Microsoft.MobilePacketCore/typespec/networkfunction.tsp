import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.MobilePacketCore;

@doc("AO5GC Network Function Resource")
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

  @doc("Type of network function")
  @visibility("create", "read")
  networkFunctionType: NetworkFunctionType;

  @doc("State of the network function")
  networkFunctionState: NetworkFunctionState;

  @doc("User provided description")
  userDescription?: string;

  @doc("User provided deployment notes.  This is used to optionally provide details about the NF deployment")
  deploymentNotes?: string;

  @doc("Billing information")
  @visibility("read")
  billing?: Billing;

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
  extends TrackedResourceOperations<NetworkFunctionResource, NetworkFunctionResourceProperties> {
    delete is ArmResourceDeleteSync<NetworkFunctionResource>;
    createOrUpdate is ArmResourceCreateOrUpdateSync<NetworkFunctionResource>
}

@doc("SKU Values")
enum SkuValues {
  ProductionKvm2,
  ProductionKvm4,
  ProductionKvm8,
  ProductionKvm16,
  ProductionKvm32,
  ProductionAzureNexus2,
  ProductionAzureNexus4,
  ProductionAzureNexus8,
  ProductionAzureNexus16,
  ProductionAzureNexus32,
  ProductionAzureCore2,
  ProductionAzureCore4,
  ProductionAzureCore8,
  ProductionAzureCore16,
  ProductionAzureCore32,
  LabKvm2,
  LabKvm4,
  LabKvm8,
  LabKvm16,
  LabKvm32,
  LabAzureNexus2,
  LabAzureNexus4,
  LabAzureNexus8,
  LabAzureNexus16,
  LabAzureNexus32,
  LabAzureCore2,
  LabAzureCore4,
  LabAzureCore8,
  LabAzureCore16,
  LabAzureCore32,
}

@doc("Type of Network Function")
enum NetworkFunctionType {
  Amf,
  Smf,
  Upf,
  Nrf,
  Nssf,
  ContainerizedMme,
  SaeGwCombined,
  SaeGwControlPlane,
  SaeGwUserPlane,
  VirtualMme,
  Epdg,
  Paas,
  Ems,
  Opm
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
