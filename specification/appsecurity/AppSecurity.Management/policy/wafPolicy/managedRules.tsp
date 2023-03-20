using OpenAPI;

namespace Microsoft.AppSecurity;

/* *********************************
 * managedRules property definitions
 ********************************* */

enum WafActionType {
  AnomalyScoring,
  Allow,
  Block,
  Log,
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
  ruleGroupName: string;

  @doc("Group level override")
  groupOverride?: StateAndActionOverride;

  @doc("List of rule level overrides")
  @extension("x-ms-identifiers", [])
  rules?: RuleOverride[];
}

@doc("Variable variants that can be excluded when defining an Exclusion")
enum ExclusionMatchVariable {
  RequestHeaderNames,
  RequestCookieNames,
  RequestArgNames,
  RequestHeaderKeys,
  RequestHeaderValues,
  RequestCookieKeys,
  RequestCookieValues,
  RequestArgKeys,
  RequestArgValues,
}

@doc("Comparison operators variants that can be used with Exclusion variables when defining an Exclusion")
enum ExclusionSelectorMatchOperator {
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'
  Contains,
  StartsWith,
  EndsWith,
  EqualsAny,
}

@doc("Defines a rule group scope, which can be the entire rule group or a subset of rule within it")
model RuleGroupScope {
  @doc("Relevant rule group name")
  ruleGroupName: string;

  @doc("Relevant rules within the specified rule group. If not specified, the scope is the entire rule group.")
  @minItems(1)
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
  @extension("x-ms-identifiers", [])
  @minItems(1)
  ruleGroups?: RuleGroupScope[];
}

@doc("Defines a managed rule set")
model ManagedRuleSet {
  @doc("The state of the rule set. Default is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Defines the rule set type to use")
  ruleSetType: string;

  @doc("Defines the version of the rule set to use")
  ruleSetVersion: string;

  @doc("Defines the rule group overrides to apply to the rule set")
  @extension("x-ms-identifiers", [])
  ruleGroupOverrides?: RuleGroupOverride[];

  @doc("The exclusions that are applied on the managed rule set")
  @extension("x-ms-identifiers", [])
  exclusions?: Exclusion[];
}
