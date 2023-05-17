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

@armProviderNamespace("Microsoft.HealthcareDataAiServices")
@service({
  title: "Microsoft.HealthcareDataAiServices",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.HealthcareDataAiServices;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A HealthcareDataAiServicesProviderHub resource")
model DeidService is TrackedResource<DeidServiceProperties> {
  @doc("The name of the deid service")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("DeidServiceName")
  @segment("DeidServices")
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

@doc("Details of the HealthcareDataAiServices DeidService.")
model DeidServiceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface DeidServices extends TrackedResourceOperations<DeidService, DeidServiceProperties> {}
