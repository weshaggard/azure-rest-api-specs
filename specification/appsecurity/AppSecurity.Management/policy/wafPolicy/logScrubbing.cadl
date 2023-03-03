using OpenAPI;

namespace Microsoft.AppSecurity;

/* *********************************
 * logScrubbing property definitions
 ********************************* */

enum ScrubbingRuleMatchVariable {
  RequestHeaderNames,
  RequestCookieNames,
  RequestArgNames,
  RequestPostArgNames,
  RequestJSONArgNames,
  RequestIPAddress,
}

enum ScrubbingRuleSelectorMatchOperator {
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'
  EqualsAny,
}

@doc("Allow certain variables to be scrubbed on WAF logs")
model ScrubbingRule {
  @doc("Defines the state of log scrubbing rule. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("The variable to be scrubbed from the logs")
  matchVariable: ScrubbingRuleMatchVariable;

  @doc("When matchVariable is a collection, operate on the selector to specify which elements in the collection this rule applies to")
  selectorMatchOperator: ScrubbingRuleSelectorMatchOperator;

  @doc("When matchVariable is a collection, operator used to specify which elements in the collection this rule applies to")
  selector: string;
}

@doc("Log scrubbing configuration, to allow certain variables to be scrubbed on WAF logs")
model LogScrubbing {
  @doc("The state of the log scrubbing config. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("The rules that are applied to the logs for scrubbing")
  @extension("x-ms-identifiers", [])
  scrubbingRules: ScrubbingRule[];
}
