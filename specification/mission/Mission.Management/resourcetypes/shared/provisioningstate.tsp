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

@doc("Provisioning State Enum")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("ProvisioningState of Type Accepted")
  Accepted,

  @doc("ProvisioningState of Type Created")
  Created,

  @doc("ProvisioningState of Type Creating")
  Creating,

  @doc("ProvisioningState of Type Deleted")
  Deleted,

  @doc("ProvisioningState of Type Deleting")
  Deleting,

  @doc("ProvisioningState of Type NotSpecified")
  NotSpecified,

  @doc("ProvisioningState of Type Ready")
  Ready,

  @doc("ProvisioningState of Type Running")
  Running,

  @doc("ProvisioningState of Type Updating")
  Updating
}