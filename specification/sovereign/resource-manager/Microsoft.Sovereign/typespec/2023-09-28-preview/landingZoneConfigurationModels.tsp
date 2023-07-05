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

	#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Handled in code."
	@doc("Optional parent for management group hierarchy, used as intermediate root management group parent, if specified. If empty, default, will deploy beneath tenant toot management group.")
	existingTopLevelMgParentId?: string;

	@doc("The prefix that will be added to all resources created by this deployment.")
	@minLength(2)
	@maxLength(5)
	deploymentPrefix: string;

	@doc("The suffix that will be added to management group name.")
	@minLength(2)
	@maxLength(5)
	deploymentSuffix?: string;

	@doc("The top level management group display name.")
	@maxLength(90)
	topLevelMgDisplayName: string;

	@doc("The name of the country/region or agency SLZ is being deployed for.")
	organization: string;

	@doc("Yes to deploy DDoS, otherwise no. To provide an existing DDoS protection plan select existing.")
	ddosProtectionCreationOption: ResourceCreationOptions;

	@doc("Existing ddos protection plan id.")
	existingDdosProtectionId?: string;

	@doc("yes to deploy log Analytics workspace, otherwise no. To provide an existing log Analytics workspace select existing.")
	logAnalyticsWorkspaceCreationOption: ResourceCreationOptions;

	@doc("The ID for the Log Analytics workspace that was created to centralize log ingest.")
	existingLogAnalyticsWorkspaceId?: string;

	@doc("Array of tag objects in format of {'name':'a tag name', 'value':'a tag value'}")
	@OpenAPI.extension("x-ms-identifiers", [])
	tags?: Tags[];

	@doc("To deploy firewall choose the standard/premium based on the desired SKU. None for no firewall and existing to choose a pre existing one.")
	firewallCreationOption: FirewallCreationOptions;

	@doc("Existing Firewall Id")
	existingFirewallId?: string;

	@doc("Azure firewall subnet. IPv4 CIDR block.")
	@pattern("^(?:\\d{1,3}\\.){3}\\d{1,3}/(?:[1-9]|[1-2]\\d|3[0-2])$")
	firewallSubnetCidrBlock?: string;

	@doc("Gateway subnet. IPv4 CIDR block.")
	@pattern("^(?:\\d{1,3}\\.){3}\\d{1,3}/(?:[1-9]|[1-2]\\d|3[0-2])$")
	gatewaySubnetCidrBlock?: string;

	@doc("Management subscription Id.")
	existingManagementSubscriptionId?: string;

	@doc("Identity subscription Id.")
	existingIdentitySubscriptionId?: string;

	@doc("Connectivity subscription Id.")
	existingConnectivitySubscriptionId?: string;

	@doc("Set how long logs are retained for, in days. Minimum length is 30 and maximum is 730")
	@minValue(30)
	@maxValue(730)
	logRetentionInDays: int64;

	@doc("Location to run deployment(s) from the list of Azure Regions")
	deploymentLocation: string;

	@doc("The address space for the VNET. IPv4 CIDR.")
	@pattern("^(?:\\d{1,3}\\.){3}\\d{1,3}/(?:[1-9]|[1-2]\\d|3[0-2])$")
	hubNetworkCidrBlock: string;

	@doc("To deploy the Bastion service choose the yes, no otherwise. For existing bastion service existing.")
	azureBastionCreationOption: ResourceCreationOptions;

	@doc("Existing azure bastion Id.")
	existingAzureBastionId?: string;

	@doc("Azure Bastion subnet. IP v4 CIDR block")
	@pattern("^(?:\\d{1,3}\\.){3}\\d{1,3}/(?:[1-9]|[1-2]\\d|3[0-2])$")
	azureBastionSubnetCidrBlock?: string;

	@doc("landing zone management group properties")
	@OpenAPI.extension("x-ms-identifiers", [])
	landingZonesMgChildren?: LandingZoneMgProperties[];

	@doc("This will be applied to the deployment root of the landing zone")
	topLevelMgMetadata?: MgProperties;

	@doc("This will be applied to the landing zones management group")
	landingZonesMgMetadata?: MgProperties;

	@doc("This will be applied to the platform management group")
	platformMgMetadata?: MgProperties;

	@doc("This will be applied to the Management management group under Platform")
	platformManagementMgMetadata?: MgProperties;

	@doc("This will be applied to the connectivity management group under Platform")
	platformConnectivityMgMetadata?: MgProperties;

	@doc("This will be applied to the identity management group under Platform")
	platformIdentityMgMetadata?: MgProperties;

	@doc("This will be applied to the decommissioned management group.")
	decommissionedMgMetadata?: DecommissionedMgProperties;

	@doc("This will be applied to the sandbox management group.")
	sandboxMgMetadata?: SandboxMgProperties;
}

@doc("Landing zone management group properties")
model LandingZoneMgProperties {
	...MgProperties;

	@doc("Management group name.")
	name: string;

	@doc("Is the management group Confidential?")
	isConfidential: boolean;

	@doc("is it open to internet?")
	isVisibleToInternet: boolean;
}

@doc("Details of policy and initiatives associated with the management group.")
model MgProperties {
	@doc("Array of initiative assignments to be applied to the management group.")
	@OpenAPI.extension("x-ms-identifiers", [])
	policyInitiativesAssignmentProperties: PolicyInitiativeAssignmentProperties[];
}

@doc("Details of policy assignments")
model PolicyInitiativeAssignmentProperties {
	@doc("The id of the policy initiatives.")
	policyInitiativeId: string;

	#suppress "@azure-tools/typespec-azure-core/bad-record-type" "This would be customer defined parameter based on the policy initiatives to be assigned. Hence we need to use Record<unknown> as it will differ per initiative."
	@doc("The parameters for the policy or initiatives.")
	assignmentParameters: Record<unknown>;
}

@doc("Decommissioned managemenrt group properties")
model DecommissionedMgProperties {
	...MgProperties;

	@doc("when set to false this MG is not created")
	create: boolean;
}

@doc("Sandbox management group properties")
model SandboxMgProperties {
	...MgProperties;

	@doc("When set to false this management group is not created.")
	create: boolean;
}

@doc("The detail of each tags")
model Tags {
	@doc("a tag name")
	name: string;

	@doc("a tag value")
	value: string;
}

@doc("The request body to generate a Landing Zone.")
model GenerateLandingZoneRequest {
	@doc("The options that code can be generated in")
	iacOutputOption: IaCOutputOptions;

	@doc("Billing scope account Id")
	billingScopeAccountId?: string;

	@doc("Enrollment Id")
	enrollmentAccountId?: string;
}

@doc("The request body to update the authoring status.")
model SetAuthoringStatusRequest {
	@doc("The value of the authoring status to be updated.")
	authoringStatus: AuthoringStatus;
}

@doc("The response for generate landing zone request.")
model GenerateLandingZoneResponse {
	@doc("The top level management group display name.")
	topLevelMgDisplayName: string;

	@doc("The name of the landing zone configuration resource.")
	landingZoneConfigurationName: string;

	@doc("The blob url where generated landing zone is stored")
	@secret
	blobUrl: url;
}

@doc("The authoring status for landing zone configuration workflow.")
enum AuthoringStatus {
	@doc("Default status set automatically on create request. In this status the landing zone configuration can be updated.")
	Authoring: "Authoring",

	@doc("This status is set when the configuration changes are done and the configuration is ready for generating the landing zone code.")
	ReadyForUse: "ReadyForUse",

	@doc("This status is set when the landing zone configuration is no longer in use.")
	Disabled: "Disabled",
}

@doc("The format in which the landing zone code can be generated.")
enum IaCOutputOptions {
	@doc("Value choosen when the customer wants to generate the code in bicep.")
	Bicep: "Bicep",

	// values to be added in the future.
	//arm: "ARM",
	//terraform: "Terraform",
}

@doc("The input values for creating or using an existing firewall resource.")
enum FirewallCreationOptions {
	@doc("Value choosen when a user does not want to create a firewall resource.")
	None: "None",

	@doc("Value choosen when a user wants to create a firewall resource of standard SKU.")
	Standard: "Standard",

	@doc("Value choosen when a user wants to create a firewall resource of premium SKU.")
	Premium: "Premium",

	@doc("Value choosen when a user wants to use an existing firewall resource.")
	UseExisting: "UseExisting",
}

@doc("Represents options for resource creation.")
enum ResourceCreationOptions {
	@doc("This option indicates that a new resource should be created.")
	Yes: "Yes",

	@doc("This option indicates that a new resource should not be created.")
	No: "No",

	@doc("This option indicates that an existing resource should be used.")
	UseExisting: "UseExisting",
}
