using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Managed rule set definition")
model ManagedRuleSet {
  @doc("The state of the rule set. Default is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  ...ManagedRuleSetId
}

@doc("Defines a managed rule set identifier")
model ManagedRuleSetId {
  @doc("Defines the type of the rule set")
  @minLength(1)
  @maxLength(30)
  ruleSetType: string;

  @doc("Defines the version of the rule set")
  @minLength(1)
  @maxLength(20)
  ruleSetVersion: string;
}
