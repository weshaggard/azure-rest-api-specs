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

namespace Microsoft.Bluefin;

@lroStatus
@doc("The provisioning status of the resource")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being created.")
  Provisioning,

  @doc("The resource is being updated.")
  Updating,

  @doc("The resource is being deleted.")
  Deleting,

  @doc("The resource is being moved.")
  Accepted,
}
