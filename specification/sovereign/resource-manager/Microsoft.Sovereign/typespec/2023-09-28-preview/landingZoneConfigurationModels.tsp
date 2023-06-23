using Azure.ResourceManager;

namespace Microsoft.Sovereign;

@doc("The properties of landing zone configuration resource type.")
model LandingZoneConfigurationProperties {
	@visibility("read")
	@doc("The status of a user-initiated, control-plane operation on the landing zone configuration.")
	provisioningState?: ResourceProvisioningState;

	@visibility("read")
	@doc("The status for the landing zone configuration workflow.")
	authoringStatus?: AuthoringStatus;

	@doc("Optional parent for management group hierarchy, used as intermediate root management group parent, if specified. If empty, default, will deploy beneath tenant toot management group.")
	topLevelMgParentId?: string;

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
	ddosProtection: ResourceCreationOptions;

	@doc("Existing ddos protection plan id.")
	ddosProtectionId?: string;

	@doc("yes to deploy log Analytics workspace, otherwise no. To provide an existing log Analytics workspace select existing.")
	logAnalyticsWorkspace: ResourceCreationOptions;

	@doc("The ID for the Log Analytics workspace that was created to centralize log ingest.")
	logAnalyticsWorkspaceId?: string;

	@doc("Array of tag objects in format of {'name':'a tag name', 'value':'a tag value'}")
	@OpenAPI.extension("x-ms-identifiers", [])
	tags?: Tags[];

	@doc("To deploy firewall choose the standard/premium based on the desired SKU. None for no firewall and existing to choose a pre existing one.")
	firewall: Firewall;

	@doc("Existing Firewall Id")
	firewallId?: string;

	@doc("Azure firewall subnet. IPv4 CIDR block.")
	@pattern("^(?:\\d{1,3}\\.){3}\\d{1,3}/(?:[1-9]|[1-2]\\d|3[0-2])$")
	firewallSubnet?: string;

	@doc("Management subscription Id.")
	managementSubscriptionId?: string;

	@doc("Identity subscription Id.")
	identitySubscriptionId?: string;

	@doc("Connectivity subscription Id.")
	connectivitySubscriptionId?: string;

	@doc("Set how long logs are retained for, in days. Minimum length is 30 and maximum is 730")
	@minValue(30)
	@maxValue(730)
	logRetentionInDays: int64;

	@doc("Location to run deployment(s) from the list of Azure Regions")
	deploymentLocation: string;

	@doc("The allowed Azure regions where resources are allowed to be deployed")
	allowedLocations: string[];

	@doc("The allowed Azure regions where confidential computing resources are allowed to be deployed")
	allowedConfidentialComputingLocations: string[];

	@doc("Hub network subnet. IPv4 CIDR")
	@pattern("^(?:\\d{1,3}\\.){3}\\d{1,3}/(?:[1-9]|[1-2]\\d|3[0-2])$")
	hubNetworkSubnet: string;

	@doc("To deploy the Bastion service choose the yes, no otherwise. For existing bastion service existing.")
	azureBastion: ResourceCreationOptions;

	@doc("Existing azure bastion Id.")
	azureBastionId?: string;

	@doc("Azure Bastion subnet. IP v4 CIDR block")
	@pattern("^(?:\\d{1,3}\\.){3}\\d{1,3}/(?:[1-9]|[1-2]\\d|3[0-2])$")
	azureBastionSubnet?: string;

	@doc("landing zone management group properties")
	@OpenAPI.extension("x-ms-identifiers", [])
	landingZonesMgChildren?: LandingZoneMgProperties[];

	@doc("This will be applied to the deployment root of the landing zone")
	topLevelMg?: MgPolicyDetails;

	@doc("This will be applied to the landing zones management group")
	landingZonesMg?: MgPolicyDetails;

	@doc("This will be applied to the platform management group")
	platformMg?: MgPolicyDetails;

	@doc("This will be applied to the Management management group under Platform")
	platformManagementMg?: MgPolicyDetails;

	@doc("This will be applied to the connectivity management group under Platform")
	platformConnectivityMg?: MgPolicyDetails;

	@doc("This will be applied to the identity management group under Platform")
	platformIdentityMg?: MgPolicyDetails;

	@doc("This will be applied to the decommissioned management group.")
	decommissionedMg?: DecommissionedMgProperties;

	@doc("This will be applied to the sandbox management group.")
	sandboxMg?: SandboxMgProperties;
}

@doc("Landing zone management group properties")
model LandingZoneMgProperties {
	...MgPolicyDetails;

	@doc("Management group name.")
	name: string;

	@doc("Is the management group Confidential?")
	isConfidential: boolean;

	@doc("is it open to internet?")
	isVisibleToInternet: boolean;
}

@doc("Details of policy and initiatives associated with the management group.")
model MgPolicyDetails {
	@doc("Array of initiative assignments to be applied to the management group.")
	@OpenAPI.extension("x-ms-identifiers", [])
	policyInitiatives: PolicyAssignmentDetails[];
}

@doc("Details of policy assignments")
model PolicyAssignmentDetails {
	@doc("The id of the policy or initiatives.")
	id: string;

	#suppress "@azure-tools/typespec-azure-core/bad-record-type" "This would be customer defined parameter based on the policy initiatives to be assigned. Hence we need to use Record<unknown> as it will differ per initiative."
	@doc("The parameters for the policy or initiatives.")
	parameters: Record<unknown>;
}

@doc("Decommissioned managemenrt group properties")
model DecommissionedMgProperties {
	...MgPolicyDetails;

	@doc("when set to false this MG is not created")
	create: boolean;
}

@doc("sandbox management group properties")
model SandboxMgProperties {
	...MgPolicyDetails;

	@doc("when set to false this MG is not created")
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
	outputFormat: OutputFormat;

	@doc("Billing scope account ID")
	billingScopeAccountId?: string;

	@doc("Enrollment iD")
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
	authoring: "Authoring",

	@doc("This status is set when the configuration changes are done and the configuration is ready for generating the landing zone code.")
	readyForUse: "ReadyForUse",

	@doc("This status is set when the landing zone configuration is no longer in use.")
	disabled: "Disabled",
}

@doc("The format in which the landing zone code can be generated.")
enum OutputFormat {
	@doc("Value choosen when the customer wants to generate the code in bicep.")
	bicep: "Bicep",

	// values to be added in the future.
	//arm: "ARM",
	//terraform: "Terraform",
}

@doc("The input values for creating or using an existing firewall resource.")
enum Firewall {
	@doc("Value choosen when a user does not want to create a firewall resource.")
	none: "None",

	@doc("Value choosen when a user wants to create a firewall resource of standard SKU.")
	standard: "Standard",

	@doc("Value choosen when a user wants to create a firewall resource of premium SKU.")
	premium: "Premium",

	@doc("Value choosen when a user wants to use an existing firewall resource.")
	existing: "Existing",
}

@doc("Represents options for resource creation.")
enum ResourceCreationOptions {
	@doc("This option indicates that a new resource should be created.")
	yes: "Yes",

	@doc("This option indicates that a new resource should not be created.")
	no: "No",

	@doc("This option indicates that an existing resource should be used.")
	existing: "Existing",
}
