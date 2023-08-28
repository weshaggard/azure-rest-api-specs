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

@doc("dsmsAllowlists Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("dsmsAllowlists properties")
model dsmsAllowlistsResourceProperties {
  @doc("The name of the folder to apply allowlist changes to. This should be the full folder path starting with a '$', with '$' replacing all '/' characters. Example: '/my-folder/root-folder' should be passed as '$my-folder$root-folder")
  folderName: string; // camel case for the parameter name

  @doc("The dSMS endpoints to apply allowlist changes to. The folder specified in FolderName will be updated on each of the TargetDsmsEndpoints. If this is left null, this will default to all the dSMS endpoints used for the root folder.")
  targetDsmsEndpoints?: Array<string>;

  @doc("Dns domain patterns in the allowlist. Patterns with '*' are accepted values here.")
  dnsPatterns? : Array<string>;

  @doc("Guids of Azure deployment subscriptions in allowlist.")
  deploymentSubscriptions? : Array<string>;

  @doc("Guids of Azure storage subscriptions in allowlist.")
  storageSubscriptions? : Array<string>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: dsmsAllowlistsProvisioningState;
}

@doc("dsmsAllowlists Resource")
model dsmsAllowlistsResource is ProxyResource<dsmsAllowlistsResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("dsmsAllowlists")// start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
enum dsmsAllowlistsProvisioningState {
  ...ResourceProvisioningState,
  @doc("Accepted State")
  Accepted
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface dsmsAllowlists {
  @doc(" dsmsAllowlists creation")
  @example("./examples/CreateDsmsAllowlist.json", "Create dsmsAllowlists")
  createOrUpdate  is ArmResourceCreateOrUpdateAsync<dsmsAllowlistsResource>;
  listBySubscription is ArmListBySubscription<dsmsAllowlistsResource>;
  listByResourceGroup is ArmResourceListByParent<dsmsAllowlistsResource>;
}