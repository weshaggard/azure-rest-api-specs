using OpenAPI;

namespace Microsoft.AppSecurity;

/* *********************************
 * policySettings property definitions
 ********************************* */

enum PolicyMode {
  Prevention,
  Detection,
}

@doc("Defines top-level policy settings")
model PolicySettings {
  @doc("The mode of the policy. Default value is Detection")
  mode?: PolicyMode = PolicyMode.Detection;

  @doc("If action type is redirect, this field represents redirect URL for the client")
  redirectUrl?: string = ""; // TODO - didn't find a url built-in type in /workspace/src/API/node_modules/@typespec/compiler/lib/lib.tsp

  @doc("If the action type is block, customer can override the response status code")
  @minValue(0)
  customBlockResponseStatusCode?: int64;

  @doc("If the action type is block, customer can override the response body. The body must be specified in base64 encoding")
  @pattern("^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$")
  customBlockResponseBody?: string;

  @doc("Describes if policy managed rules will inspect the request body content. Default value is Enable")
  requestBodyCheck?: EnabledState = EnabledState.Enabled;

  @doc("Maximum request body size in Kb for WAF")
  @minValue(8)
  maxRequestBodySizeInKb?: int32; // TODO - currently we ignore this setting for AFD apps

  @doc("Maximum file upload size in Mb for WAF")
  @minValue(0)
  fileUploadLimitInMb?: int32; // TODO - currently we ignore this setting for AFD apps
}
