import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/compiler";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Reflection;

@armProviderNamespace("Microsoft.365ConsumptionServices")
@service({
  title: "Microsoft.365ConsumptionServices",
})
@doc("AdminMonetizationTest Resource Provider management API.")
@versioned(Microsoft.ConsumptionServices.Versions)
namespace Microsoft.ConsumptionServices;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A 365ConsumptionServicesProviderHub resource")
model Service is TrackedResource<ServiceProperties> {
  @doc("The name of the service.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ServiceName")
  @segment("Services")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Update in progress")
  Updating,

  @doc("Deletion in progress")
  Deleting,

  @doc("Change accepted for processing")
  Accepted,
}

@doc("Details of the 365ConsumptionServices Service.")
model ServiceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Tenant Id.")
  tenantId: string;

  @doc("Usage Type.")
  usageType: int64;
}

@armResourceOperations
interface Services extends TrackedResourceOperations<Service, ServiceProperties> {
}

@doc("Versions.")
enum Versions {
  @doc("Versions.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_08_01_preview: "2023-08-01-preview",
}