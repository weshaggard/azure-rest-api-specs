import "./common.tsp";
using Azure.ResourceManager;

@doc("The properties of landing zone resource type.")
model LandingZoneProperties {
	@visibility("read")
	@doc("The status of a user-initiated, control-plane operation on the landing zone resource type.")
	provisioningState?: ProvisioningState;

	@doc("The associated landing zone configuration resource.")
	landingZoneConfigurationId: string;

	@doc("The top level management group id.")
	@minLength(4)
	@maxLength(10)
	topLevelManagementGroupId: string;
}
