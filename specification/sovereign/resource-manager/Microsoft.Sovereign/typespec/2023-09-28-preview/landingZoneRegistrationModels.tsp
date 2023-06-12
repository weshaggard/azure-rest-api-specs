using Azure.ResourceManager;

namespace Microsoft.Sovereign;

@doc("The properties of landing zone registration resource type.")
model LandingZoneRegistrationProperties {
	@visibility("read")
	@doc("The status of a user-initiated, control-plane operation on the landing zone registration resource type.")
	provisioningState?: ResourceProvisioningState;

	@doc("The associated landing zone configuration resource.")
	landingZoneConfigurationId: string;

	@doc("The top level management group id.")
	@minLength(4)
	@maxLength(10)
	topLevelMgId: string;
}
