import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using OpenAPI;

namespace Microsoft.MobilePacketCore;

@doc("Azure for Operators 5G Core AMF Deployment Resource")
@resource("amfDeployments")
model AmfDeploymentResource
  is TrackedResource<AmfDeploymentResourceProperties> {
  @doc("The name of the AMF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("amfDeploymentName")
  @path
  @segment("amfDeployments")
  @visibility("create", "read")
  name: string;

  ...ManagedServiceIdentity;
}

@doc("AMF Deployment Properties.")
model AmfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Usage SKU")
  @visibility("create", "read")
  usageSku: UsageSku;

  @doc("Simultaneously Attached Users (SAU)")
  @visibility("read")
  simultaneouslyAttachedUsersCount?: int32;

  @doc("Azure keyvault used for provisioning the network function. For example: https://contosovault.vault.azure.net/")
  keyVault: url;

  @doc("Deployment status")
  @visibility("read")
  deploymentStatus?: DeploymentStatus;
}

@armResourceOperations(AmfDeploymentResource)
interface AmfDeployments {
  get is ArmResourceRead<AmfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<AmfDeploymentResource>;
  updateTags is ArmTagsPatchSync<AmfDeploymentResource>;
  delete is ArmResourceDeleteSync<AmfDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<AmfDeploymentResource>;
  listBySubscription is ArmListBySubscription<AmfDeploymentResource>;
}
