using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Sovereign;

@doc("The properties of landing zone configuration resource type.")
model LandingZoneConfigurationProperties {
	@visibility("read")
	@doc("The status of a user-initiated, control-plane operation on the landing zone configuration.")
	provisioningState?: ResourceProvisioningState;

	#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Handled in code."
	@visibility("read")
	@doc("The status for the landing zone configuration workflow.")
	authoringStatus?: AuthoringStatus;

	@doc("To deploy DDoS, choose Yes, otherwise No. Select Existing to provide an existing DDoS protection plan.")
	ddosProtectionCreationOption: ResourceCreationOptions;

	@doc("Existing DDoS protection plan fully qualified Id.")
	existingDdosProtectionId?: string;

	@doc("To deploy Log Analytics workspace, choose Yes, otherwise No. Select 'Existing' to provide an existing Log Analytics workspace.")
	logAnalyticsWorkspaceCreationOption: ResourceCreationOptions;

	@doc("The fully qualified Id for the Log Analytics workspace that was created to centralize log ingest.")
	existingLogAnalyticsWorkspaceId?: string;

	@doc("Array of tag objects in format of {'name':'a tag name', 'value':'a tag value'}.")
	@OpenAPI.extension("x-ms-identifiers", [])
	tags?: Tags[];

	@doc("To deploy firewall, choose the Standard/Premium based on the desired SKU. Choose None for no firewall and Existing for a pre existing one.")
	firewallCreationOption: FirewallCreationOptions;

	@doc("Azure firewall subnet. IPv4 CIDR block.")
	firewallSubnetCidrBlock?: string;

	@doc("Gateway subnet. IPv4 CIDR block.")
	gatewaySubnetCidrBlock: string;

	@doc("Set how long logs are retained for, in days. Minimum length is 30 and maximum is 730")
	@minValue(30)
	@maxValue(730)
	logRetentionInDays: int64;

	@doc("The address space for the VNET. IPv4 CIDR block.")
	hubNetworkCidrBlock: string;

	@doc("To deploy the Bastion service, choose Yes, otherwise No. Choose Existing for existing Bastion service.")
	azureBastionCreationOption: ResourceCreationOptions;

	@doc("Existing Azure Bastion fully qualified Id.")
	existingAzureBastionId?: string;

	@doc("Azure Bastion subnet. IP v4 CIDR block.")
	azureBastionSubnetCidrBlock?: string;

	@doc("Landing zone children management group properties")
	@OpenAPI.extension("x-ms-identifiers", [])
	landingZonesMgChildren?: LandingZoneMgProperties[];

	@doc("This will be applied to the root of the Landing Zone deployment.")
	topLevelMgMetadata?: MgProperties;

	@doc("This will be applied to the Landing Zone Management Groups.")
	landingZonesMgMetadata?: MgProperties;

	@doc("This will be applied to the Platform Management Group.")
	platformMgMetadata?: MgProperties;

	@doc("This will be applied to the Management Management Group under Platform.")
	platformManagementMgMetadata?: MgProperties;

	@doc("This will be applied to the Connectivity Management Group under Platform.")
	platformConnectivityMgMetadata?: MgProperties;

	@doc("This will be applied to the Identity Management Group under Platform.")
	platformIdentityMgMetadata?: MgProperties;

	@doc("This will be applied to the Decommissioned Management Group.")
	decommissionedMgMetadata?: DecommissionedMgProperties;

	@doc("This will be applied to the Sandbox Management Group.")
	sandboxMgMetadata?: SandboxMgProperties;
}

@doc("Landing Zone Management Group properties.")
model LandingZoneMgProperties {
	...MgProperties;

	@doc("Management Group name.")
	name: string;
}

@doc("Details of the policy and initiatives associated with the Management Group.")
model MgProperties {
	@doc("Array of initiative assignments to be applied to the Management Group.")
	@OpenAPI.extension("x-ms-identifiers", [])
	policyInitiativesAssignmentProperties: PolicyInitiativeAssignmentProperties[];
}

@doc("Details of policy assignments")
model PolicyInitiativeAssignmentProperties {
	@doc("The fully qualified Id of the policy initiatives.")
	policyInitiativeId: string;

	#suppress "@azure-tools/typespec-azure-core/bad-record-type" "This would be customer defined parameter based on the policy initiatives to be assigned. Hence we need to use Record<unknown> as it will differ per initiative."
	@doc("The parameters for the assignment of policy initiatives.")
	assignmentParameters: Record<unknown>;
}

@doc("Decommissioned Management Group properties.")
model DecommissionedMgProperties {
	...MgProperties;

	@doc("When set to false, this Management Group will not be created.")
	create: boolean;
}

@doc("Sandbox Management Group properties.")
model SandboxMgProperties {
	...MgProperties;

	@doc("When set to false this Management Group will not be created.")
	create: boolean;
}

@doc("The details associated with tags.")
model Tags {
	@doc("A tag name.")
	name: string;

	@doc("A tag value.")
	value: string;
}

@doc("The request to generate code for a Landing Zone.")
model GenerateLandingZoneRequest {
	@doc("The export options available for code generation.")
	iacOutputOption: IaCOutputOptions;

	@doc("Management subscription fully qualified Id.")
	existingManagementSubscriptionId?: string;

	@doc("Identity subscription fully qualified Id.")
	existingIdentitySubscriptionId?: string;

	@doc("Connectivity subscription fully qualified Id.")
	existingConnectivitySubscriptionId?: string;

	@doc("Billing scope account Id")
	billingScopeAccountId?: string;

	@doc("Enrollment Id")
	enrollmentAccountId?: string;

	@doc("Optional parent for Management Group hierarchy, used as intermediate root management group parent, if specified. If empty, default will deploy beneath tenant toot management group.")
	existingTopLevelMgParentId?: string;

	@doc("The prefix that will be added to all resources created by this deployment.")
	@minLength(2)
	@maxLength(5)
	@pattern("^([a-zA-Z0-9-]*)$")
	deploymentPrefix: string;

	@doc("The suffix that will be added to Management Group names.")
	@minLength(2)
	@maxLength(5)
	deploymentSuffix?: string;

	@doc("The top level management group display name.")
	@minLength(1)
	@maxLength(90)
	topLevelMgDisplayName: string;

	@doc("Location to run deployment(s) from the list of Azure Regions.")
	@pattern("^([a-zA-Z0-9]+)$")
	deploymentLocation: string;

	@doc("The name of the country, region or agency the Landing Zone is being deployed for.")
	organization?: string;
}

@doc("The response for the request to generate Landing Zone code.")
model GenerateLandingZoneResponse {
	@doc("The top level Management Group display name.")
	topLevelMgDisplayName: string;

	@doc("The name of the Landing Zone configuration resource.")
	landingZoneConfigurationName: string;

	@doc("The blob URL where the generated code for the Landing Zone will be stored.")
	@secret
	blobUrl: url;
}

@doc("The request to update authoring status of a configuration.")
model SetAuthoringStatusRequest {
	@doc("The value of the authoring status to be updated.")
	authoringStatus: AuthoringStatus;
}

@doc("The response for the request to set authoring status.")
model SetAuthoringStatusResponse {
	@doc("The name of the Landing Zone configuration resource.")
	landingZoneConfigurationName: string;

	@doc("The value of the authoring status to be updated.")
	authoringStatus: AuthoringStatus;
}

@doc("The authoring status for a Landing Zone configuration.")
enum AuthoringStatus {
	@doc("This is the default status when a create configuration request is made. In this state, the Landing Zone configuration can be updated.")
	Authoring: "Authoring",

	@doc("This status is set when the configuration changes are complete and the configuration is ready for code generation")
	ReadyForUse: "ReadyForUse",

	@doc("This status is set when the landing zone configuration is no longer in use.")
	Disabled: "Disabled",
}

@doc("Output options for Landing Zone code generation.")
enum IaCOutputOptions {
	@doc("Value when generating Landing Zone code in Bicep.")
	Bicep: "Bicep",

	// values to be added in the future.
	//arm: "ARM",
	//terraform: "Terraform",
}

@doc("The input values for creating or using an existing firewall resource.")
enum FirewallCreationOptions {
	@doc("Value when a firewall resource is not created.")
	None: "None",

	@doc("Value when the firewall creation is based on the Standard SKU.")
	Standard: "Standard",

	@doc("Value when the firewall creation is based on the Premium SKU.")
	Premium: "Premium",
}

@doc("Options for resource creation.")
enum ResourceCreationOptions {
	@doc("Value to create a new resource.")
	Yes: "Yes",

	@doc("Value to not create a new resource.")
	No: "No",

	@doc("Value to use an existing resource.")
	UseExisting: "UseExisting",
}
