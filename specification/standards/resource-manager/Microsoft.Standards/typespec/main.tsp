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

@armProviderNamespace("Microsoft.Standards")
@service({
  title: "Microsoft.Standards",
})
@versioned(Microsoft.Standards.Versions)
namespace Microsoft.Standards;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v1: "2023-10-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@subscriptionResource
model Deployment is ProxyResource<DeploymentProperties> {
  @doc("The name of the standard deployment")
  @key("deploymentName")
  @segment("deployments")
  @path
  name: string;
}

@doc("Details of the Standard deployment.")
model DeploymentProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
  @doc("Data for the deployment.")
  data: string;
}

@armResourceOperations
interface Deployments extends ProxyResourceOperations<Deployment> {
}
