using Azure.ResourceManager;

namespace Microsoft.Sovereign;

@doc("The properties of the Landing Zone registration resource type.")
model LandingZoneRegistrationProperties {
	@visibility("read")
	@doc("The status of a user-initiated, control-plane operation on the Landing Zone registration resource type.")
	provisioningState?: ResourceProvisioningState;

	@doc("The top level Management Group Id.")
	existingTopLevelMgId: string;

	@doc("The associated Landing Zone configuration Id.")
	existingLandingZoneConfigurationId: string;
}
