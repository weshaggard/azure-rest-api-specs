import "./common.tsp";
using Azure.ResourceManager;

@doc("The properties of Landing Zone resource type.")
model LandingZoneProperties {
	@visibility("read")
	@doc("The status of a user-initiated, control-plane operation on the Landing Zone Configuration.")
	provisioningState?: ProvisioningState;

	@doc("The associated Landing Zone Configuration.")
	landingZoneConfigurationId?: string;

	@doc("The top level management group name.")
	topLevelManagementGroupName?: string;
}
