import "./webProtection.tsp";
import "./botProtection.tsp";
import "./policySettings.tsp";
import "./protectedEndpoint.tsp";
import "./customRules.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("The Policy properties")
model PolicyProperties {
  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Global settings for the policy")
  policySettings: PolicySettings;

  @doc("The list of endpoints this policy protects")
  @extension("x-ms-identifiers", ["endpointId"])
  @maxItems(100)
  protectedEndpoints?: ProtectedEndpoint[];

  @doc("Rules for scrubbing sensitive log fields")
  logScrubbing?: LogScrubbing;

  @doc("User defined rules")
  @extension("x-ms-identifiers", ["name"])
  @maxItems(100) // AppGW custom rules limitation is 100
  customRules?: CustomRule[];

  @doc("Describes the web protection policy")
  webProtection?: WebProtection;

  @doc("Describes the bot protection policy")
  botProtection?: BotProtection;
}

@doc("Policy resource definition")
model Policy is TrackedResource<PolicyProperties> {
  //@pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the policy")
  @segment("policies") // Path segment
  @key("policyName")
  @path
  @minLength(1)
  @maxLength(128)
  name: string;
  // ...ResourceSku;
}

@doc("Request or response body of endpoints attachment/detachment operation")
model ProtectedEndpointList {
  @maxItems(100)
  @extension("x-ms-identifiers", ["endpointId"])
  @doc("List of endpoints to attach/detach to the policy, or that are currently protected by the policy")
  protectedEndpoints: ProtectedEndpoint[];
}

@armResourceOperations
interface Policies {
  get is ArmResourceRead<Policy>;
  listByParent is ArmResourceListByParent<Policy>;
  listBySubscription is ArmListBySubscription<Policy>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Policy>;
  update is ArmResourcePatchAsync<Policy, PolicyProperties>;
  delete is ArmResourceDeleteAsync<Policy>;
}
