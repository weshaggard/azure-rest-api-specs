import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./instance.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Bluefin;

@doc("A Pipeline resource belonging to an Instance resource.")
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
  update is ArmResourcePatchAsync<Pipeline, PipelineProperties>;
  delete is ArmResourceDeleteAsync<Pipeline>;
  listByInstance is ArmResourceListByParent<Pipeline>;
}
