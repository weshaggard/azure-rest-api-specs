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
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Microsoft.EdgeZonesV2")
@service({
  title: "Microsoft.EdgeZonesV2",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.EdgeZonesV2;

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

@doc("The status of the subscription's' Microsoft EdgeZone registration.")
enum RegistrationState {
  NotRegistered,
  PendingApproval,
  Registered,
}

@doc("The properties of a NicrosoftEdgeZone Resource")
model MicrosoftEdgeZoneProperties {
  @visibility("readOnly")
  @doc("The status of the last operation. required property on a resource https://stackoverflow.microsoft.com/questions/327894")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("MicrosoftEdgeZone registration approved or not")
  registrationState?: RegistrationState;
}

@doc("A MicrosoftEdgeZone resource")
@subscriptionResource
model MicrosoftEdgeZone is ProxyResource<MicrosoftEdgeZoneProperties> {
  @doc("The name of the MicrosoftEdgeZone")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("microsoftEdgeZoneName")
  @segment("microsoftEdgeZones")
  @path
  name: string;
}

@autoRoute
@armResourceAction(TResource)
@post
op ArmResourceActionNoBodyNoContentSync<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmNoContentResponse<"Action completed successfully."> | ErrorResponse;

 @armResourceOperations
 interface MicrosoftEdgeZones {
  get is ArmResourceRead<MicrosoftEdgeZone>;
  listBySubscription is ArmListBySubscription<MicrosoftEdgeZone>;

  @doc("Registers a subscription for a Microsoft Edge Zone")
  Register is ArmResourceActionNoBodyNoContentSync<MicrosoftEdgeZone>;

  @doc("Unregisters a subscription for a Microsoft Edge Zone")
  Unregister is ArmResourceActionNoBodyNoContentSync<MicrosoftEdgeZone>;
}


