import "./customRules.tsp";
import "./logScrubbing.tsp";
import "./managedRules.tsp";
import "./policySettings.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AppSecurity;

/* *********************************
 * Policy resource definitions
 ********************************* */

@doc("WAF Policy definition")
model WafPolicy {
  @doc("The state of the policy. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Describes settings for the policy")
  policySettings: PolicySettings;

  @doc("Describes the managedRules structure")
  @extension("x-ms-identifiers", [])
  managedRules: ManagedRuleSet[];

  @doc("The custom rules inside the policy")
  @extension("x-ms-identifiers", [])
  @maxItems(100) // AppGW custom rules limitation is 100
  customRules: CustomRule[];

  @doc("To scrub sensitive log fields")
  logScrubbing?: LogScrubbing;
}
