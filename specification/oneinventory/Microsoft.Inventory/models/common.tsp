import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Inventory;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Provisionsingin state enum")
enum ProvisioningState {
  Provisioning,
  Updating,
  Deleting,
  Accepted,
  Succeeded,
  Failed,
  Canceled,
}
