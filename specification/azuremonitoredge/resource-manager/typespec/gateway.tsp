import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@service({
    title: "Managed OpenTelemetry Collector Resource Provider",
    version: "2023-06-21-privatepreview",
  })
@doc("Resource provider for Managed instances of OpenTelemetry Collectors.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureMonitorEdge;

@doc("OpenTelemetry Collector Gateway resource")
model Gateway is TrackedResource<GatewayProperties> {
    @doc("Name of the instance of the OtelCollector")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("instanceName")
    @path
    @segment("gateways")
    name: string
}

@doc("OtelCollector properties")
model GatewayProperties {
    @doc("Configuration of the OtelCollector")
    config: string,
    
    @visibility("read")
    @doc("Gets and sets the property provisioningState. The status of the last operation.")
    provisioningState?: ProvisioningState;
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
    ...ResourceProvisioningState,

    @doc("The resource is being provisioned")
    Provisioning,

    @doc("The resource is updating")
    Updating,

    @doc("The resource is being deleted")
    Deleting,

    @doc("The resource create request has been accepted")
    Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Gateways {
  get is ArmResourceRead<Gateway>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Gateway>;
  update is ArmResourcePatchSync<Gateway, GatewayProperties>;
  delete is ArmResourceDeleteSync<Gateway>;
  listByResourceGroup is ArmResourceListByParent<Gateway>;
  listBySubscription is ArmListBySubscription<Gateway>;
}
