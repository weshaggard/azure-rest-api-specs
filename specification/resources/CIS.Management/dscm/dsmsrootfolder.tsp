import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCIS;

@doc("dsmsRootFolder properties")
model DsmsRootFolderResourceProperties {
  @doc("The ServiceTreeId that owns the new root folder")
  serviceTreeId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  @doc("The name of the root folder to add. This should be the full folder path starting with a \"$\", with \"$\" replacing all \"/\" characters")
  name: string;

  @doc("The cloud ID where the root folder should be added. Acceptable values: Public, Fairfax, Mooncake, USSec, USNat")
  cloudId?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: dsmsRootFolderProvisioningState;
}

@doc("dsmsRootFolder Resource")
model DsmsRootFolderResource
  is ProxyResource<DsmsRootFolderResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("dsmsRootFolders") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DsmsRootFolder {
  @doc(" dsmsRootFolder creation")
  @example(
    "./examples/CreateDsmsRootFolder.json",
    "Create dsmsRootFolder"
  )
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DsmsRootFolderResource>;
  listBySubscription is ArmListBySubscription<DsmsRootFolderResource>;
  listByResourceGroup is ArmResourceListByParent<DsmsRootFolderResource>;
}

@doc("Provisioning status of the resource.")
enum dsmsRootFolderProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}
