import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Bluefin;

@doc("A Instance resource is a logical container for a set of child resources.")
model Instance is TrackedResource<InstanceProperties> {
  @doc("Name of instance.")
  @key("instanceName")
  @segment("instances")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;

  // Extended location is not included in TrackedResource yet
  @doc("Edge location of the resource.")
  @visibility("read","create")
  extendedLocation?: ExtendedLocation;
}

@doc("The properties of a Instance resource.")
model InstanceProperties {
  @doc("User-friendly name for the Instance.")
  displayName: string;

  @doc("Location of the Open Telemetry collector that logs, traces and metrics are sent to.")
  otelCollectorAddress: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Instances {
  get is ArmResourceRead<Instance>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Instance>;
  update is ArmResourcePatchAsync<Instance, InstanceProperties>; // This needs to be async
  delete is ArmResourceDeleteAsync<Instance>;
  listByResourceGroup is ArmResourceListByParent<Instance>;
  listBySubscription is ArmListBySubscription<Instance>;
}
