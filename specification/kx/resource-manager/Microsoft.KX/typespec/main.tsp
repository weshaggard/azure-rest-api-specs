import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armProviderNamespace("Microsoft.KX")
@service({
  title: "KX Resource Provider",
  version: "2022-11-01-preview",
})
@Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.KX;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;

@doc("A kdbInsightsEnterprise resource")
model KdbInsightsEnterpriseResource is TrackedResource<KdbInsightsEnterpriseProperties> {
  @doc("The name of the kdbInsightsEnterprise resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("kdbInsightsEnterpriseName")
  @segment("kdbInsightsEnterprise")
  @path
  name: string;
}

@lroStatus
@doc("The full set of provisioning states")
enum ProvisioningState {
  ...Azure.ResourceManager.ResourceProvisioningState,
  @doc("Provisioning the resource is in progress")
  Provisioning,
  @doc("Resource is being updated")
  Updating,
  @doc("Resource is being deleted")
  Deleting,
  @doc("The change request has been accepted")
  Accepted,
}

@secret
scalar PasswordString extends string;

@doc("Configuration of the managed resource group associated with the resource.")
model ManagedResourceGroupConfiguration {
  @doc("The resource group name.")
  name: string;

  @doc("The resource group location.")
  location: string;
}

@doc("Details of the kdbInsightsEnterprise resource.")
model KdbInsightsEnterpriseProperties {
  @visibility("create")
  @doc("The password to use for KeyCloak")
  @pattern("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])[a-zA-Z0-9!@#\\$%\\^&\\*]{14,320}$")
  keyCloakPassword?: PasswordString;

  @visibility("create")
  @doc("The password to use for the UI")
  @pattern("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])[a-zA-Z0-9!@#\\$%\\^&\\*]{14,320}$")
  uiPassword?: PasswordString;

  @visibility("read", "create")
  @doc("Email address for licensing and certificate registration")
  @pattern("^(?=.{1,320}$)(?=[^@]{1,64}@)\\w+([\\.\\-\\+\\w]*)@(?=.{1,255}$)\\w+([\\.\\-]?\\w+)*(\\.\\w{2,3})+$")
  emailAddress?: string;

  @visibility("read", "create")
  @doc("The UI user name")
  @pattern("^[A-Za-z0-9]{8,20}$")
  uiUsername?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("Configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;
}

@armResourceOperations
interface KdbInsightsEnterprise extends Azure.ResourceManager.TrackedResourceOperations<KdbInsightsEnterpriseResource, KdbInsightsEnterpriseProperties> {}

interface Operations extends Azure.ResourceManager.Operations {}