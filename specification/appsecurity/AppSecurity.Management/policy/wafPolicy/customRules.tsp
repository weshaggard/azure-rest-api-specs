using OpenAPI;
using TypeSpec.Rest;

namespace Microsoft.AppSecurity;

/* *********************************
 * customRules property definitions
 ********************************* */

enum IpOperatorVariable {
  ClientAddr,
  // SocketAddr, // Only for AFD
}

enum GeoOperatorVariable {
  ClientAddr,
  // SocketAddr, // Only for AFD
  // RequestHeader, // Only for AppGW. TODO - will be added if it's a parity requirement
}

enum WithSelectorOperatorVariable {
  RequestHeader,
  PostArgs,
  RequestCookies,
}

enum StringSizeNumberOperatorVariable {
  QueryString,
  RequestMethod,
  RequestUri,
  RequestBody,
  ...WithSelectorOperatorVariable,
}

enum StringNumberOperatorVariable {
  ...StringSizeNumberOperatorVariable,
}

enum SizeOperatorVariable {
  ...StringSizeNumberOperatorVariable,
}
enum StringOperatorVariable {
  ...StringSizeNumberOperatorVariable,
}
enum ExistsOperatorVariable {
  ...WithSelectorOperatorVariable,
}

//TODO - no Equal?
enum SizeOrNumberOperator {
  LessThan,
  GreaterThan,
  LessThanOrEqual,
  GreaterThanOrEqual,
}

enum StringOperator {
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'
  Contains,
  BeginsWith,
  EndsWith,
  Regex,
  GeoMatch,
}

@doc("Describes the override action to be applied when custom rule matches")
enum CustomRuleActionType {
  Allow,
  Deny,
  Log,
  Redirect, // Assuming AppGW supports this
  AnomalyScoring,
}

enum TransformType {
  Uppercase,
  Lowercase,
  Trim,
  UrlDecode,
  UrlEncode,
  RemoveNulls,
  HtmlEntityDecode,
}

// Currently not in use
// If we want to add this defintion, we need to add PROPFIND, PROPPATCH and MKCOL to custom-words.txt
// enum RequestMethodType {
//   OPTIONS,
//   GET,
//   HEAD,
//   POST,
//   PUT,
//   DELETE,
//   PROPFIND,
//   PROPPATCH,
//   MKCOL,
//   COPY,
//   MOVE,
//   LOCK,
//   UNLOCK,
//   PROFILE,
//   PATCH,
// }

/* *********************************
 * CustomRuleCondition definitions
 ********************************* */

@doc("Defines a custom rule condition")
@discriminator("conditionType")
model CustomRuleCondition {
  @doc("Whether this is negate the condition. Default is false")
  negationCondition?: boolean = false;
}

@doc("Defines a custom rule condition of type Ip")
model IpMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: "Ip";

  @doc("Variable to match against")
  matchVariable: IpOperatorVariable;

  @doc("IP list fully qualified resource ID")
  matchValue: IpListResourceId;
}

@doc("Defines a custom rule condition of type Geo")
model GeoMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: "Geo";

  @doc("Variable to match against")
  matchVariable: GeoOperatorVariable;
  // TODO - needed only if RequestHeader is a possible match variable
  // @doc("Match against a specific key from RequestHeader. Default is null")
  // selector?: string;


  @doc("Geo list fully qualified resource ID")
  matchValue: GeoListResourceId;
}

@doc("Defines a custom rule condition of type String")
model StringMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: "String";

  @doc("String operator to use when matching with the match values")
  operator: StringOperator;

  @doc("Variable to match against")
  matchVariable: StringOperatorVariable;
  @doc("Match against a specific key from RequestHeader, PostArgs and RequestCookies. Default is Null") // TODO - generate this doc according to WithSelectorOperatorVariable
  selector?: string;

  @doc("The condition is met if any of the values match the variable with the given operator")
  matchValue: string[];

  @doc("Describes what transforms applied before matching")
  transformations?: TransformType[];
}

// TODO - add number match condition, although currently it is not included in the feature subset.
// SizeMatchCondition isn't included in the feature subset.
// @doc("Defines a custom rule size condition")
// model SizeMatchCondition extends CustomRuleCondition {
//   @doc("Defines the operation type")
//   conditionType: "Size";

//   @doc("Size operator to use when matching with the match value")
//   operator: SizeOrNumberOperator;

//   @doc("Variable to match against")
//   matchVariable: SizeOperatorVariable;

//   @doc("Match against a specific key from RequestHeader, PostArgs and RequestCookies. Default is Null")
//   selector?: string;

//   @doc("If this value match the variable with the given operator, this condition is met")
//   @minValue(0)
//   matchValue: int64;

//   @doc("Describes what transforms applied before matching")
//   transformations?: TransformType[];
// }

@doc("Defines a custom rule condition of type Exists")
model ExistsMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: "Exists";

  @doc("Variable to match against")
  matchVariable: ExistsOperatorVariable;

  @doc("This condition is met if the matchValue is one of the matchVariable's keys")
  matchValue: string;
}

// TODO - improve limit type naming
enum RateLimitType {
  ClientIp,
  Geo,
  DestinationIp,
}

// TODO - get scheme from AFD/AppGW
@doc("Describes the rate limit configuration of a rule")
model RateLimit {
  @doc("Rate limiting is done based on the limit type")
  limitType: RateLimitType;

  @doc("Time window for resetting the rate limit count. Default is 1 minute")
  @minValue(1)
  @maxValue(5)
  durationInMinutes?: int64 = 1;

  @doc("Max number of allowed requests per limit type, within the defined duration")
  @minValue(1)
  maxRequestsPerSecond: int64;
}

@doc("Defines contents of a web application rule")
model CustomRule {
  @doc("The name of the rule")
  name?: string;

  @doc("The state of the custom rule. Default is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Describes what action to be applied when rule matches")
  action: CustomRuleActionType;

  @doc("Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value")
  @minValue(0) // Assuming AppGW "100" doesn't exist anymore
  @maxValue(65535) // This is basically an int16, which is not supported in Azure resource manager
  priority: int32;

  @doc("Enables and configures a rate limit mechanism for the rule")
  rateLimit?: RateLimit;

  @doc("A list of conditions that must be met for the actions to be executed")
  @extension("x-ms-identifiers", [])
  @minItems(1)
  matchConditions: CustomRuleCondition[];
}
