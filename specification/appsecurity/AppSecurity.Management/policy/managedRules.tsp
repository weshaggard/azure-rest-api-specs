using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Supported action that can be applied if a rule matches")
enum WafActionType {
  @doc("Anomaly scoring action")
  AnomalyScoring,

  @doc("Allow the request")
  Allow,

  @doc("Block the request")
  Block,

  @doc("Log the request and allow it")
  Log,

  @doc("Redirect the request")
  Redirect, // TODO - this is not valid for appGW
}

@doc("Defines a managed rule or rule group override")
model StateAndActionOverride {
  @doc("The state of the managed rule or rule group")
  state: EnabledState;

  @doc("Overrides the action to be applied when a rule matches")
  action?: WafActionType;
}

@doc("Defines a managed rule group override setting")
model RuleOverride {
  @doc("Identifier for the managed rule")
  ruleId: string;

  ...StateAndActionOverride;
}

// TODO - in the current model a RuleGroupOverride without groupOverride or rules is valid. We need to make sure at least one of them is valid.
@doc("Defines a managed rule group override setting")
model RuleGroupOverride {
  @doc("The managed rule group to override")
  @minLength(1)
  @maxLength(128)
  ruleGroupName: string;

  @doc("Group level override")
  groupOverride?: StateAndActionOverride;

  @doc("List of rule level overrides")
  @extension("x-ms-identifiers", ["ruleId"])
  @maxItems(100)
  rules?: RuleOverride[];
}

@doc("Variable variants that can be excluded when defining an Exclusion")
enum ExclusionMatchVariable {
  @doc("The request header")
  RequestHeaderNames,

  @doc("The request cookie")
  RequestCookieNames,

  @doc("The request argument")
  RequestArgNames,

  @doc("The request header keys")
  RequestHeaderKeys,

  @doc("The request header value")
  RequestHeaderValues,

  @doc("The request cookie keys")
  RequestCookieKeys,

  @doc("The request cookie values")
  RequestCookieValues,

  @doc("The request argument keys")
  RequestArgKeys,

  @doc("The request argument values")
  RequestArgValues,
}

@doc("Comparison operators variants that can be used with Exclusion variables when defining an Exclusion")
enum ExclusionSelectorMatchOperator {
  @doc("Equals")
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'

  @doc("Contains")
  Contains,

  @doc("Starts with")
  StartsWith,

  @doc("Ends with")
  EndsWith,

  @doc("Equals any")
  EqualsAny,
}

@doc("Defines a rule group scope, which can be the entire rule group or a subset of rule within it")
model RuleGroupScope {
  @doc("Relevant rule group name")
  ruleGroupName: string;

  @doc("Relevant rules within the specified rule group. If not specified, the scope is the entire rule group.")
  @maxItems(100)
  rules?: string[];
}

@doc("Allow to exclude some variable satisfy the condition for the WAF check")
model Exclusion {
  @doc("The variable to be excluded")
  matchVariable: ExclusionMatchVariable;

  @doc("When matchVariable is a collection, operate on the selector to specify which elements in the collection this exclusion applies to")
  selectorMatchOperator: ExclusionSelectorMatchOperator;

  @doc("When matchVariable is a collection, operator used to specify which elements in the collection this exclusion applies to")
  selector?: string;

  @doc("Exclusion scope. If not specified, then the exclusion is applied to the entire rule set")
  @extension("x-ms-identifiers", ["ruleGroupName"])
  @maxItems(100)
  ruleGroups?: RuleGroupScope[];
}

@doc("Defines a managed rule set")
model ManagedRuleSet {
  @doc("The state of the rule set. Default is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Defines the rule set type to use")
  @minLength(1)
  @maxLength(30)
  ruleSetType: string;

  @doc("Defines the version of the rule set to use")
  @minLength(1)
  @maxLength(20)
  ruleSetVersion: string;

  @doc("Defines the rule group overrides to apply to the rule set")
  @extension("x-ms-identifiers", ["ruleGroupName"])
  @maxItems(100)
  ruleGroupOverrides?: RuleGroupOverride[];

  @doc("The exclusions that are applied on the managed rule set")
  @extension("x-ms-identifiers", [])
  @maxItems(100)
  exclusions?: Exclusion[];
}
