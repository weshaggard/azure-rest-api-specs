import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "RP operations defined under quantum"
@armProviderNamespace("Microsoft.Quantum")
@service({
  title: "Microsoft.Quantum",
  version: "2023-04-17-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Quantum;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A QuantumProviderHub resource")
model CmsWorkspace is TrackedResource<CmsWorkspaceProperties> {
  @doc("The name of the CMS Workspace.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("workspaceName")
  @segment("CmsWorkspaces")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("Details of the Quantum CMS Workspace.")
model CmsWorkspaceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface CmsWorkspaces extends TrackedResourceOperations<CmsWorkspace, CmsWorkspaceProperties> {}