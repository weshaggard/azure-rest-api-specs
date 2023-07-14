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

@armProviderNamespace
@service({
  title: "Microsoft.Bluefin management service",
  version: "2023-06-26-preview",
})
@doc("Microsoft.Bluefin Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Bluefin;

interface Operations extends Azure.ResourceManager.Operations {}

/************************************* Instance *************************************/
@doc("Instance resource")
model Instance is TrackedResource<InstanceProperties> {
  @doc("Name of instance")
  @key("instanceName")
  @segment("instances")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@doc("Instance properties")
model InstanceProperties {
  @doc("User-friendly name for the instance.")
  displayName: string;

  @doc("Location of the Openn Telemetry collector that logs, traces and metrics are sent to.")
  otelCollectorAddress: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Instances {
  get is ArmResourceRead<Instance>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Instance>;
  update is ArmResourcePatchSync<Instance, InstanceProperties>; // This needs to be async
  delete is ArmResourceDeleteSync<Instance>;
  listByResourceGroup is ArmResourceListByParent<Instance>;
  listBySubscription is ArmListBySubscription<Instance>;
}

/************************************* Pipeline *************************************/
@doc("A pipeline resource belonging to a instance resource.")
@parentResource(Instance)
model Pipeline is ProxyResource<PipelineProperties> {
  @doc("Name of pipeline")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("pipelineName")
  @path
  @segment("pipelines")
  name: string;
}

@doc("The input of a Pipeline resource.")
model PipelineInput {
}

@doc("The properties of a Pipeline resource.")
model PipelineProperties {
  @doc("User-friendly name for the pipeline.")
  displayName: string;

  @doc("Detailed description of the pipeline for customer consumption.")
  description?: string;

  @doc("Flag indicating whether the pipeline should be running or not.")
  enabled: boolean;

  @doc("The input of a Pipeline resource.")
  input: PipelineInput;
  
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Pipelines {
  get is ArmResourceRead<Pipeline>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Pipeline>;
  update is ArmResourcePatchSync<Pipeline, PipelineProperties>;
  delete is ArmResourceDeleteSync<Pipeline>;
  listByInstance is ArmResourceListByParent<Pipeline>;
}

/************************************* Dataset *************************************/
@doc("A dataset resource belonging to a instance resource.")
@parentResource(Instance)
model Dataset is ProxyResource<DatasetProperties> {
  @doc("Name of dataset")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("datasetName")
  @path
  @segment("datasets")
  name: string;
}

@doc("The properties of a Dataset resource.")
model DatasetProperties {
  @doc("User-friendly name for the Dataset.")
  displayName: string;

  @doc("Path to the payload in the message. Enrich will add only the payload to the enriched message, other fields will not be kept except for in the indexes.")
  payload?: string;

  @doc("Path to an RFC3339 timestamp. If no path is provided, the ingestion time of the record is used for time-based joins.")
  timestamp?: string;

  @doc("Time to live.")
  ttl?: string;

  @doc("List of keys that can be used for joining on enrich")
  keys?: DatasetPropertyKeys;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("List of keys that can be used for joining on enrich.")
model DatasetPropertyKeys {

}

@armResourceOperations
interface Datasets {
  get is ArmResourceRead<Dataset>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Dataset>;
  update is ArmResourcePatchSync<Dataset, DatasetProperties>;
  delete is ArmResourceDeleteSync<Dataset>;
  listByInstance is ArmResourceListByParent<Dataset>;
}

/************************************* Shared *************************************/
@lroStatus
@doc("The provisioning status of the resource")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being created.")
  Provisioning,

  @doc("The resource is being updated.")
  Updating,

  @doc("The resource is being deleted.")
  Deleting,

  @doc("The resource is being moved.")
  Accepted,
}