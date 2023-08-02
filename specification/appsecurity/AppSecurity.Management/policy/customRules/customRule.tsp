import "./matchCondition.tsp";

using OpenAPI;
using TypeSpec.Rest;

namespace Microsoft.AppSecurity;

@doc("Defines a custom rule")
@discriminator("ruleType")
model CustomRule {
  @doc("The name of the rule")
  @minLength(1)
  @maxLength(128)
  @pattern("^[a-zA-Z][a-zA-Z0-9]*$")
  name: string;

  @doc("The state of the custom rule. Default is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Describes what action to be applied when rule matches")
  action: CustomRuleActionType;

  @doc("Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value")
  @minValue(0) // Assuming AppGW "100" doesn't exist anymore
  @maxValue(65535) // This is basically an int16, which is not supported in Azure resource manager
  priority: int32;

  // TODO - move this inside the specific custom rule type <https://msazure.visualstudio.com/One/_backlogs/backlog/DDoS%20ILDC/Features/?workitem=24659181>
  // Use the following doc for RateBased custom rule
  // @doc("The list of conditions that must be met for an incoming request to be included in the rate calculation")
  @doc("A list of conditions that must be met for the actions to be executed")
  @extension("x-ms-identifiers", [])
  @minItems(1)
  @maxItems(10)
  matchConditions: CustomRuleCondition[];
}

@doc("User defined rule to execute an action if conditions are met on an incoming request")
model MatchCustomRule extends CustomRule {
  @doc("Defines the rule type")
  ruleType: "MatchBased";
}

@doc("User defined rule that is triggered by the rate of incoming requests")
model RateBasedCustomRule extends CustomRule {
  @doc("Defines the rule type")
  ruleType: "RateBased";

  @doc("Configures a rate limit mechanism for the rule")
  rateLimit: RateLimit;
}

@doc("Describes the rate limit configuration of a rate limit custom rule")
model RateLimit {
  @doc("The time duration for which the rate limit threshold is enforced. Default value is 1 minute")
  durationInMinutes: DurationInMinutes = DurationInMinutes.One;

  @doc("If the total number of requests exceeds this threshold during a rate limit duration, the rate limit action will be invoked")
  @minValue(1)
  threshold: int32;

  @doc("Group requests based on their type and apply rate limits to each group independently. Default is ClientAddr based grouping")
  groupBy: RateLimitGroupByType = RateLimitGroupByType.ClientAddr;
}

@doc("Defines the available grouping options for rate limiting")
enum RateLimitGroupByType {
  @doc("Grouping based on client address")
  ClientAddr,

  @doc("Grouping is based on the geographic location of the request")
  GeoLocation,

  @doc("No grouping is being done. Rate limit is global")
  None,
}

@doc("Duration in minutes")
enum DurationInMinutes {
  @doc("One minute")
  One: 1,

  @doc("Five minutes")
  Five: 5,
}
