import "./wafPolicy/wafPolicy.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Definition of an application attachment")
model AppAttachment {
  @doc("Fully qualified ARM ID of the application to protect")
  appId: ProtectedAppId;

  @doc("The state of the attachment")
  protectionState?: EnabledState = EnabledState.Enabled;

  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/* *********************************
 * Policy resource definitions
 ********************************* */

@doc("The Policy properties")
model PolicyProperties {
  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The state of the policy. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("The list of applications this policy protects")
  @extension("x-ms-identifiers", ["appId"])
  protectedApps: AppAttachment[];

  @doc("Describes the WAF policy")
  wafPolicy: WafPolicy;
}

@doc("Policy resource definition")
model Policy is TrackedResource<PolicyProperties> {
  //@pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the policy")
  @segment("policies") // Path segment
  @key("policyName")
  @path
  name: string;
  ...ResourceSku;
  // ...ManagedServiceIdentity; // change here to use the standard definition
  // ...ManagedBy;
}

@armResourceOperations(Policy)
interface Policies
  extends TrackedResourceOperations<Policy, PolicyProperties> {}
