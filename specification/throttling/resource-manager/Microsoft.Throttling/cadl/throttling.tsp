import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

@doc("Azure Throttling Solutions (ATS)")
@service({
  title: "Azure Throttling"
})
@versioned(Versions)
@armProviderNamespace
namespace Microsoft.Throttling;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2, Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2022_06_01_preview: "2022-06-01-preview",
}

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Autorest;
using Azure.ResourceManager;
using OpenAPI;

interface Operations extends Azure.ResourceManager.Operations {
  checkName is checkGlobalNameAvailability;
  checkLocalName is checkLocalNameAvailability;
}

@doc("Provisioning state")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  @doc("Resource being created")
  Creating,
  @doc("Resource being updated")
  Updating,
  @doc("Resource being deleted")
  Deleting
}

@doc("Throttling account")
model Account is TrackedResource<AccountProperties> {
  @doc("Account name")
  @key("accountName")
  @segment("accounts")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations(Account)
interface Accounts extends TrackedResourceOperations<Account, AccountProperties> {}

@doc("Account properties")
model AccountProperties {
  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Endpoint address to be used by Throttling client")
  @visibility("read")
  hostName?: string;

  @doc("Account authentication properties")
  authentication: AuthenticationProperties;
}

@doc("Account authentication properties")
model AuthenticationProperties {
  @doc("Certificate-based authentication properties")
  @extension("x-ms-identifiers", [ "subjectName" ])
  certificates?: CertificateProperties[];

  @doc("AzureAD-based authentication properties")
  azureActiveDirectory?: AzureActiveDirectoryProperties;
}

@doc("Certificate-based authentication properties")
model CertificateProperties {
  @doc("Certificate subject name")
  subjectName: string;
}

@doc("AzureAD-based authentication properties")
model AzureActiveDirectoryProperties {
  @doc("List of permitted user-assigned managed identities")
  @minItems(1)
  userAssignedIdentities: UserAssignedManagedIdentityReference[]
}

@doc("User-assigned managed identity ARM resource id")
scalar UserAssignedManagedIdentityReference extends ResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

@doc("Throttling category")
@parentResource(Account)
model Category is ProxyResource<CategoryProperties> {
  @doc("Category name")
  @key("categoryName")
  @segment("categories")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations(Category)
interface Categories extends TrackedResourceOperations<Category, CategoryProperties> {}

@doc("Category properties")
model CategoryProperties {
  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Window duration")
  windowDuration: duration;

  @doc("Threshold value")
  @minValue(1)
  threshold: int32;

  @doc("Depth of the bucket")
  @minValue(0)
  @maxValue(16)
  depth: int32;
  
  @doc("Minimal decision duration")
  minDecisionDuration: duration;
}
