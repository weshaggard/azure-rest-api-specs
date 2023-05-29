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

// Define an Azure Resource Manager service.
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style."
@armProviderNamespace
@service({
  title: "AdminMonetizationTest Services Spec"
})
@doc("AdminMonetizationTest Resource Provider management API.")
@versioned(Microsoft.AdminMonetizationTestNamespace.Versions) 
namespace Microsoft.AdminMonetizationTestNamespace;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Supress duplicate property."
@doc("Admin RP Azure resource properties")
model AdminResourceProperties {
  @doc("The name of my resource.")
  name: string;

  @doc("The id of my resource.")
  id: string;

  @doc("The type of my resource.")
  type: string;

  @visibility("read")
  @doc("The provisioning state of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Properties.")
  properties: Properties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing template"
@doc("A AdminGraphServices resource.")
model AdminResource is TrackedResource<AdminResourceProperties>
{
  @doc("The Name of the employee.")
  @key("AdminResourceName")
  @segment("AdminResources")
  @path
  name: string;
}

// List the available operations for Resource Manager resources.
@armResourceOperations
interface AdminResourceProviderResourceOperations {
  @doc("Returns list of operations.")
  get is ArmResourceRead<AdminResource>;

  @doc("Creates resource.")
  create is ArmResourceCreateOrUpdateAsync<AdminResource>;

  @doc("Update resource.")
  update is ArmResourcePatchSync<AdminResource, AdminResourceProperties>;

  @doc("Delete resource.")
  delete is ArmResourceDeleteSync<AdminResource>;

  @doc("List by resource group.")
  listByResourceGroup is ArmResourceListByParent<AdminResource>;

  @doc("List by subscription.")
  listBySubscription is ArmListBySubscription<AdminResource>;
}

@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_05_21: "2023-05-21-preview",
}


@doc("Properties.")
model Properties{
  @doc("Tenant Id.")
  tenantId: string;

  @doc("Feature Id.")
  featureId: string;
}