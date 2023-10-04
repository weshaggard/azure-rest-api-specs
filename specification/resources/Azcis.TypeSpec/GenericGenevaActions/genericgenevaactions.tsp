import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
  version: "2023-08-22-preview",
})
@doc("GenericGenevaActions Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("GenericGenevaActions properties")
model GenericGenevaActionsResourceProperties {
  @doc("User given name for geneva action")
  name: string;

  @doc("The execution environment for geneva action")
  environment: string;

  @doc("The extension name for geneva action")
  extension: string;

  @doc("The endpoint name for geneva action")
  endpoint: string;

  @doc("The operation for geneva action")
  operation: string;

  @doc("The input mode for geneva action (single/batch)")
  inputMode?: string;

  @doc("The parameter list for geneva action")
  parameters?: Array<Parameter>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: genericGenevaActionsProvisioningState;
}

@doc("genericGenevaActions Resource")
model GenericGenevaActionsResource
  is ProxyResource<GenericGenevaActionsResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("genericGenevaActionss") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
enum genericGenevaActionsProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}

@doc("GenericGenevaActions Resource Parameter")
model Parameter { // this can be TrackedResource based on resourcetype
  @doc("Parameter name.")
  name: string;

  @doc("Parameter value.")
  value: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface GenericGenevaActions {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GenericGenevaActionsResource>;
  listBySubscription is ArmListBySubscription<GenericGenevaActionsResource>;
  listByResourceGroup is ArmResourceListByParent<GenericGenevaActionsResource>;
}
