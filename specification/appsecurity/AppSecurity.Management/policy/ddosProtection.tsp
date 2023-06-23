import "./managedRules.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("DDoS protection policy definition")
model DdosProtection {
  @doc("Describes the managedRules structure")
  @extension("x-ms-identifiers", ["ruleSetType", "ruleSetVersion"])
  @minItems(1)
  @maxItems(10)
  managedRules: ManagedRuleSet[];
}
