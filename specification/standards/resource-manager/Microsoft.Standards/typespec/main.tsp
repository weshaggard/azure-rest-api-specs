import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

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
  RollingBack,
}

@subscriptionResource
model Deployment is ProxyResource<DeploymentProperties> {
  @doc("The name of the standard deployment")
  @pattern("^[A-Za-z0-9][A-Za-z0-9_-]*$")
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
  @doc("The region of the deployment")
  region: string;
  @doc("Signed data blob.")
  data: string;
  @visibility("read")
  @extension("x-ms-identifiers", [])
  @doc("The deployment status history")
  statusHistory: DeploymentStatus[];
}

@doc("Deployment status")
model DeploymentStatus {
  @doc("The timestamp")
  timestamp: string;
  @doc("Status level")
  level: DeploymentStatusLevel;
  @doc("Status code")
  code: string;
  @doc("Status message")
  message: string;
}

@doc("The deployment status level")
enum DeploymentStatusLevel {
  Info,
  Error,
}

@doc("Rollback parameters")
model RollbackParameters {
}

@armResourceOperations
interface Deployments extends ProxyResourceOperations<Deployment> {
  @doc("Start a rollback of all regions in this deployment")
  @action("rollback")
  rollback is ArmResourceActionNoContentSync<Deployment, RollbackParameters>;
}
