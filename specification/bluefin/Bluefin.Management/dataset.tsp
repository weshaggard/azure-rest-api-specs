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
model DatasetPropertyKeys {}

@armResourceOperations
interface Datasets {
  get is ArmResourceRead<Dataset>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Dataset>;
  update is ArmResourcePatchAsync<Dataset, DatasetProperties>;
  delete is ArmResourceDeleteAsync<Dataset>;
  listByInstance is ArmResourceListByParent<Dataset>;
}
