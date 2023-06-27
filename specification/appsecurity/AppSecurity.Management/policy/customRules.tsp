using OpenAPI;
using TypeSpec.Rest;

namespace Microsoft.AppSecurity;

/* *********************************
 * customRules property definitions
 ********************************* */

@doc("Defines the operator variables for the Ip match operation")
enum IpOperatorVariable {
  @doc("The client IP address")
  ClientAddr,
  // SocketAddr, // Only for AFD
}

@doc("Defines the operator variables for the Geo match operation")
enum GeoOperatorVariable {
  @doc("The client IP address")
  ClientAddr,
  // SocketAddr, // Only for AFD
  // RequestHeader, // Only for AppGW. TODO - will be added if it's a parity requirement
}

@doc("Defines the operator variable that requires a selector")
enum WithSelectorOperatorVariable {
  @doc("Request header")
  RequestHeader,
  @doc("Post arguments")
  PostArgs,
  @doc("Request cookies")
  RequestCookies,
}

@doc("Defines the supported operator variables for string, size and number operations")
enum StringSizeNumberOperatorVariable {
  @doc("Query string")
  QueryString,
  @doc("Request method")
  RequestMethod,
  @doc("Request URI")
  RequestUri,
  @doc("Request body")
  RequestBody,
  ...WithSelectorOperatorVariable,
}

// enum StringNumberOperatorVariable {
//   ...StringSizeNumberOperatorVariable,
// }

// enum SizeOperatorVariable {
//   ...StringSizeNumberOperatorVariable,
// }

@doc("Defines the supported operator variables for string operations")
enum StringOperatorVariable {
  ...StringSizeNumberOperatorVariable,
}

@doc("Defines the supported operator variables for an operation of type Exists")
enum ExistsOperatorVariable {
  ...WithSelectorOperatorVariable,
}

//TODO - no Equal?
// @doc("Operators that can be applied in conditions of type Size or Number")
// enum SizeOrNumberOperator {
//   LessThan,
//   GreaterThan,
//   LessThanOrEqual,
//   GreaterThanOrEqual,
// }

@doc("Operators that can be applied in conditions of type String")
enum StringOperator {
  @doc("Equals")
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'
  @doc("Contains")
  Contains,
  @doc("Starts with")
  BeginsWith, // TODO - change to StartsWith so it would be consistent with managedRules.tsp ExclusionSelectorMatchOperator
  @doc("Ends with")
  EndsWith,
  @doc("Regex match")
  Regex,
  @doc("Geographic match")
  GeoMatch,
}

@doc("Describes the override action to be applied when custom rule matches")
enum CustomRuleActionType {
  @doc("Allow the request")
  Allow,
  @doc("Deny the request")
  Deny,
  @doc("Allow the request and log it")
  Log,
  @doc("Redirect the request")
  Redirect, // Assuming AppGW supports this
  @doc("Use Anomaly Scoring to decide wether to allow or deny")
  AnomalyScoring,
}

@doc("Transforms that can be applied before matching")
enum TransformType {
  @doc("Converts the string to uppercase")
  Uppercase,
  @doc("Converts the string to lowercase")
  Lowercase,
  @doc("Trims the string")
  Trim,
  @doc("Performs URL decoding")
  UrlDecode,
  @doc("Performs URL encoding")
  UrlEncode,
  @doc("Removes nulls")
  RemoveNulls,
  @doc("Performs HTML entity decoding")
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
  // As for now, we only support explicit IpLists
  // @doc("IP list fully qualified resource ID")
  // matchValue: IpListResourceId;


  @doc("A list of mutually disjoint IP addresses or CIDR ranges (IPv4 or IPv6)")
  @minItems(1)
  @maxItems(600)
  matchValue: string[];
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

  // As for now, we only support explicit GeoLists
  // @doc("Geo list fully qualified resource ID")
  // matchValue: GeoListResourceId;


  @doc("List of countries or regions")
  @minItems(1)
  @maxItems(100)
  matchValue: string[];
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
  @minLength(1)
  @maxLength(128)
  selector?: string;

  @doc("The condition is met if any of the values match the variable with the given operator")
  @minItems(1)
  @maxItems(10)
  matchValue: string[]; //TODO - restrict maxLength

  @doc("Describes what transforms applied before matching")
  @maxItems(20)
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
  @minLength(0)
  @maxLength(1024)
  matchValue: string;
}

// TODO - improve limit type naming
@doc("Supported rate limiting types")
enum RateLimitType {
  @doc("Rate limiting is done based on the client IP")
  ClientIp,
  @doc("Rate limiting is done based on the geographic location of the request")
  Geo,
  @doc("Rate limiting is done based on the destination IP")
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
  @minLength(1)
  @maxLength(128)
  @pattern("^[a-zA-Z][a-zA-Z0-9]*$")
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
  @maxItems(10)
  matchConditions: CustomRuleCondition[];
}
