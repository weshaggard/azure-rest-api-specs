import "./common.tsp";
using Azure.ResourceManager;

@doc("The properties of Landing Zone Configuration resource type.")
model LandingZoneConfigurationProperties {
	@visibility("read")
	@doc("The status of a user-initiated, control-plane operation on the Landing Zone Configuration.")
	provisioningState?: ProvisioningState;

	@visibility("read")
	@doc("The state of Landing Zone Configuration.")
	publishStatus?: PublishStatus;

	@doc("The prefix that will be added to all resources created by this deployment.")
	@minLength(2)
	@maxLength(5)
	deploymentPrefix: string;

	@doc("The suffix that will be added to management group name.")
	@minLength(2)
	@maxLength(5)
	deploymentSuffix?: string;

	@doc("the top level management group name.")
	topLevelManagementGroupName: string;

	@doc("The name of the country/region or agency SLZ is being deployed for.")
	organization: string;

	@doc("yes to deploy DDoS, otherwise no. To provide an existing DDoS protection plan select existing.")
	ddosProtection: DdosProtection;

	@doc("Existing ddos protection plan id.")
	ddosProtectionId?: string;

	@doc("The ID for the Log Analytics workspace that was created to centralize log ingest.")
	logAnalyticsWorkspaceId?: string;

	@doc("Telemetry Output")
	telemetryOutput: boolean;

	@doc("Array of tag objects in format of {'name':'a tag name', 'value':'a tag value'}")
	@OpenAPI.extension("x-ms-identifiers", [])
	tags?: Tags[];

	@doc("To deploy firewall choose the standard/premium based on the desired SKU. None for no firewall and existing to choose a pre existing one.")
	firewall: Firewall;

	@doc("Existing Firewall Id")
	firewallId?: string;

	@doc("Azure Firewall subnet. IPv4 CIDR block.")
	//TODO : Add Regex
	@pattern("")
	firewallSubnet: string;

	@doc("Management Subscription Id.")
	managementSubscriptionId?: string;

	@doc("Identity Subscription Id.")
	identitySubscriptionId?: string;

	@doc("Connectivity Subscription Id.")
	connectivitySubscriptionId?: string;

	@doc("The type of environment being deployed.")
	environment: Environment;

	@doc("Set how long logs are retained for, in days. Minimum length is 30 and maximum is 730")
	logRetentionInDays: string;

	@doc("Location to run deployment(s) from the list of Azure Regions")
	deploymentLocation: string;

	@doc("The allowed Azure regions where resources are allowed to be deployed")
	allowedLocations: Array<string>;

	@doc("The allowed Azure regions where confidential computing resources are allowed to be deployed")
	allowedConfidentialComputingLocations: Array<string>;

	@doc("Hub network subnet. IPv4 CIDR")
	//TODO : Add Regex
	hubNetworkSubnet?: string;

	@doc("To deploy the Bastion service choose the yes, no otherwise. For existing bastion service existing.")
	azureBastion: AzureBastion;

	@doc("Existing azure bastion Id.")
	azureBastionId?: string;

	@doc("Azure Bastion subnet. IP v4 CIDR block")
	//TODO : Add Regex
	azureBastionSubnet?: string;

	@doc("landing zone management group properties")
	@OpenAPI.extension("x-ms-identifiers", [])
	landingZonesManagementGroups?: ManagementGroupProperties[];

	@doc("This will be applied to the deployment root of the landing zone")
	rootMg: ManagementGroupPolicyDetails;

	@doc("This will be applied to the Landing Zones management group")
	landingZonesMg: ManagementGroupPolicyDetails;

	@doc("This will be applied to the Platform management group")
	platformMg: ManagementGroupPolicyDetails;

	@doc("This will be applied to the Management management group under Platform")
	platformManagementMg: ManagementGroupPolicyDetails;

	@doc("This will be applied to the Connectivity management group under Platform")
	platformConnectivityMg: ManagementGroupPolicyDetails;

	@doc("This will be applied to the Identity management group under Platform")
	platformIdentityMg: ManagementGroupPolicyDetails;

	@doc("This will be applied to the decommissioned management group.")
	decommissionedMg: DecommissionedMgProperties;

	@doc("This will be applied to the sandbox management group.")
	sandboxMg: SandboxMgProperties;
}

@doc("Landing zone management group properties")
model ManagementGroupProperties {
	...ManagementGroupPolicyDetails;

	@doc("Management group name.")
	name: string;

	@doc("Is the management group Confidential?")
	isConfidential: boolean;

	@doc("is it open to internet?")
	isVisibleToInternet: boolean;
}

@doc("Details of policy and initiatives associated with the management group.")
model ManagementGroupPolicyDetails {
	@doc("Array of policy assignments to be applied to the management group.")
	@OpenAPI.extension("x-ms-identifiers", [])
	policies: Array<PolicyAssignmentDetails>;

	@doc("Array of initiative assignments to be applied to the management group.")
	@OpenAPI.extension("x-ms-identifiers", [])
	policySets: Array<PolicyAssignmentDetails>;
}

@doc("Details of policy assignments")
model PolicyAssignmentDetails {
	@doc("The id of the policy or initiatives.")
	id: string;

	@doc("The parameters for the policy or initiatives.")
	parameters: object;
}

@doc("Decommissioned managemenrt group properties")
model DecommissionedMgProperties {
	...ManagementGroupPolicyDetails;

	@doc("when set to false this MG is not created")
	create: boolean;
}

@doc("sandbox management group properties")
model SandboxMgProperties {
	...ManagementGroupPolicyDetails;

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

@doc("URL for storage")
model GenerateLandingZoneRequest {
	@doc("The options that code can be generated in")
	outputFormat: OutputFormat;

	@doc("Billing scope account ID")
	billingScopeAccountId?: string;

	@doc("Enrollment iD")
	enrollmentAccountId?: string;
}

@doc("response URL for storage")
model GenerateLandingZoneResponse {
	@visibility("read")
	@doc("The blob url where generated Landing Zone is stored")
	blobUrl?: string;
}

enum PublishStatus {
	configuring: "Configuring",
	active: "Active",
	inactive: "Inactive",
}

enum OutputFormat {
	bicep: "Bicep",
	arm: "ARM",
	terraform: "Terraform",
}

enum Firewall {
	none: "None",
	standard: "Standard",
	premium: "Premium",
	existing: "Existing",
}

enum Environment {
	dev: "Dev",
	stage: "Stage",
	ga: "GA",
	prod: "Prod",
	test: "Test",
	demo: "Demo",
}

enum AzureBastion {
	yes: "Yes",
	no: "No",
	existing: "Existing",
}

enum DdosProtection {
	yes: "Yes",
	no: "No",
	existing: "Existing",
}

enum ExemptionCategory {
	mitigate: "Mitigated",
	waiver: "Waiver",
}

enum AssignmentScopeValidation {
	default: "Default",
	doNotValidate: "DoNotValidate",
}
