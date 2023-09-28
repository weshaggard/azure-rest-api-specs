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
  version: "2023-08-22-preview"
})

@doc("https://eng.ms/docs/products/azcis-resource-provisioning/template-user-guide/resources/geneva/geneva-actions-extension-resource-template")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("GenevaActionsExtension properties")
model GenevaActionsExtensionResourceProperties {
  @doc("User provided package source branch.")
  packageSourceBranch: string; // camel case for the parameter names

  @doc("This is the sub folder path to the package folder relative to the branch root.")
  packageSourceRelativePath: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: genevaActionsExtensionsProvisioningState;
}

@doc("GenevaActionsExtension Resource")
model GenevaActionsExtensionResource is ProxyResource<GenevaActionsExtensionResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("genevaActionsExtensions")// start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
enum genevaActionsExtensionsProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface GenevaActionsExtensions {
  createOrUpdate  is ArmResourceCreateOrUpdateAsync<GenevaActionsExtensionResource>;
  listBySubscription is ArmListBySubscription<GenevaActionsExtensionResource>;
  listByResourceGroup is ArmResourceListByParent<GenevaActionsExtensionResource>;
}
