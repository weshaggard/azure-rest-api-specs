import "./webProtection.tsp";
import "./apiProtection.tsp";
import "./botProtection.tsp";
import "./policySettings.tsp";
import "./customRules.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Protected endpoint definition")
model ProtectedEndpoint {
  @doc("Fully qualified ARM ID of the endpoint to protect")
  endpointId: ProtectedEndpointId;

  @doc("The status of the last attachment operation between the policy and the endpoint")
  @visibility("read")
  attachmentState?: ProvisioningState;
}

@doc("The Policy properties")
model PolicyProperties {
  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Describes settings for the policy")
  policySettings: PolicySettings;

  @doc("The list of endpoints this policy protects")
  @extension("x-ms-identifiers", ["endpointId"])
  @maxItems(100)
  @visibility("read")
  protectedEndpoints?: ProtectedEndpoint[];

  @doc("Rules for scrubbing sensitive log fields")
  logScrubbing?: LogScrubbing;

  @doc("The custom rules inside the policy")
  @extension("x-ms-identifiers", ["name"])
  @maxItems(100) // AppGW custom rules limitation is 100
  customRules: CustomRule[];

  @doc("Describes the web protection policy")
  webProtection: WebProtection;

  @doc("Describes the API protection policy")
  apiProtection: ApiProtection;

  @doc("Describes the bot protection policy")
  botProtection: BotProtection;
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
  delete is ArmResourceDeleteAsync<Policy>;
  tagsUpdate is ArmTagsPatchSync<Policy>;
  // TODO add update for individual properties.
  // e.g., update is ArmResourcePatchAsync<Policy, PolicyProperties>;
  // If we use ResourceSku, we must support update for sku property as well
  @doc("Attach the policy to a list of endpoints")
  attach is ArmResourceActionAsync<
    Policy,
    ProtectedEndpointList,
    ProtectedEndpointList
  >;
  @doc("Detach the policy from a list of endpoints")
  detach is ArmResourceActionAsync<
    Policy,
    ProtectedEndpointList,
    ProtectedEndpointList
  >;
}
