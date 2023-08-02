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

  @doc("Accepted")
  Accepted,

  @doc("Created")
  Created,

  @doc("Creating")
  Creating,

  @doc("Deleted")
  Deleted,

  @doc("Deleting")
  Deleting,

  @doc("NotSpecified")
  NotSpecified,

  @doc("Ready")
  Ready,

  @doc("Running")
  Running,

  @doc("Updating")
  Updating
}