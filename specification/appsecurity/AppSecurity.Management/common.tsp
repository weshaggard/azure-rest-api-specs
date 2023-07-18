import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AppSecurity;

@doc("The provisioning state of a resource type")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Provisioning the resource is in progress")
  Provisioning,

  @doc("Resource is being updated")
  Updating,

  @doc("Resource is being deleted")
  Deleting,

  @doc("The change request has been accepted")
  Accepted,
}

@doc("Describes whether an object (a policy, a custom rule, a managed rule set or other objects) is enabled or disabled")
enum EnabledState {
  @doc("The object is enabled")
  Enabled,

  @doc("The object is disabled")
  Disabled,
}

scalar ProtectedEndpointId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.Network/applicationGateways",
    },
    {
      type: "Microsoft.Network/applicationGateways/httpListeners",
    },
    {
      type: "Microsoft.Network/applicationGateways/requestRoutingRules",
    },
    {
      type: "Microsoft.Cdn/profiles ",
    },
    {
      type: "Microsoft.Cdn/profiles/afdEndpoints",
    },
    {
      type: "Microsoft.Cdn/profiles/afdEndpoints/customDomains",
    },
    {
      type: "Microsoft.Cdn/profiles/afdEndpoints/routes",
    }
  ]>;
