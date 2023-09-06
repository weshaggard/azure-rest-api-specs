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
@doc("Microsoft.365ConsumptionServices Resource Provider management API.")
@versioned(Microsoft.ConsumptionServices.Versions)
namespace Microsoft.ConsumptionServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The provisioning state of a resource.")
@Azure.Core.lroStatus
enum ProvisioningState {
    ...Azure.ResourceManager.ResourceProvisioningState
}

@doc("Service properties.")
model ServiceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Tenant id.")
  @visibility("create", "read")
  @pattern("(^[A-Za-z0-9]{8}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{12}?)$")
  tenantId: string;

  @doc("Usage type.")
  @visibility("create", "read")
  @minValue(1)
  usageType: int32;
}

@doc("A 365ConsumptionServices resource")
model Service is TrackedResource<ServiceProperties> {
  ...Azure.ResourceManager.Foundations.TrackedResourceBase;

  @doc("The name of the service.")
  @visibility("read")
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface Services {
  get is ArmResourceRead<Service>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Service>;
  update is ArmResourcePatchSync<Service, ServiceProperties>;
  delete is ArmResourceDeleteSync<Service>;
  listByResourceGroup is ArmResourceListByParent<Service>;
  listBySubscription is ArmListBySubscription<Service>;
}

@doc("Versions.")
enum Versions {
  @doc("Versions.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_08_01_preview: "2023-08-01-preview",
}