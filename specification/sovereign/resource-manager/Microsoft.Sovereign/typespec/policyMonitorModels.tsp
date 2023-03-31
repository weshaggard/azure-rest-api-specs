using Azure.ResourceManager;

@doc("Details of the sovereign policy monitor resource type.")
model PolicyMonitorProperties {
	@visibility("read")
	@doc("The status of the operation.")
	provisioningState?: ProvisioningState;

	@visibility("read")
	@doc("The status of the policy monitor.")
	monitorStatus?: MonitorStatus;

	@visibility("read")
	@doc("The validation status of the SLZ based on the last run of validation for the associated SLZ.")
	slzValidationStatus?: SLZValidationStatus;

	@visibility("read")
	@doc("The details of the last run of validation for the associated SLZ.")
	slzValidationDescription?: string;

	@doc("The top level management group of the SLZ")
	topLevelManagementGroup: string;

	@doc("The category of the SLZ policies to be monitored.")
	@OpenAPI.extension("x-ms-identifiers", [])
	monitorCategories: MonitorCategory[];

	@doc("The channel to alert for divergence identified with the SLZ.")
	@knownValues(AlertChannel)
	alertChannel: string;

	@doc("The email address for alerting when alert channel is email. Recommended to be a Distribution List")
	@pattern("^\\w+([.-]?\\w+)*@\\w+([.-]?\\w+)*(.\\w{2,3})+$")
	alertingEmailAddress?: string;

	@doc("The azure monitor Id when alert channel is azure monitor.")
	azureMonitorId?: string;

	@OpenAPI.extension("x-ms-identifiers", [])
	@doc("The azure monitor Id when alert channel is azure monitor.")
	customerAllowedExclusions?: AllowedExclusion[];

	@visibility("read")
	@doc("The tenant id of the resource.")
	tenantId?: string;
}

@doc("properties of the slzvalidate proxyresource type.")
model SlzValidationProperties {
	@visibility("read")
	@doc("The status of the operation.")
	provisioningState?: ProvisioningState;

	@doc("The id of the policymonitor resource.")
	policyMonitorResourceId?: string;
}

@doc("The exclusions allowed by a customer.")
model AllowedExclusion {
	@doc("the policy set for with the exclusion.")
	policySetDefinitionId: string;

	@doc("the policy for with the exclusion.")
	policyDefinitionId: string;

	@visibility("read")
	@doc("the status of the exclusion.")
	exclusionStatus: ExclusionStatus;
}

@doc("The request object to invoke SLZ validation.")
model ValidateRequest {
	@doc("The top level management group of the SLZ")
	topLevelManagementGroup: string;
}

@doc("The request object to invoke monitoring of the SLZ.")
model MonitorRequest {
	@doc("The top level management group of the SLZ")
	topLevelManagementGroup: string;

	@doc("The category of the SLZ policies to be monitored.")
	monitorCategory: MonitorCategory;
}

/*
The provisioning status of the Resource. The current status are listed below -
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Updating,
  Deleting,
  Accepted
*/
@doc("The status of the policy monitor operations.")
@Azure.Core.lroStatus
enum ProvisioningState {
	...ResourceProvisioningState,
	Provisioning,
	Updating,
	Deleting,
	Accepted,
}

@doc("The result associated with a monitor/validation execution.")
model Result {
	@doc("The details of the validation run.")
	resultDescription: string;
}

@doc("The validation record of a particular SLZ.")
model ValidationResult extends Result {
	@doc("The Name of the validation Result.")
	name: string;

	@doc("The datetime when the validation was triggered.")
	startedOn?: zonedDateTime;

	@doc("The datetime when the validation was completed.")
	completedOn?: zonedDateTime;

	@doc("The outcome of the validation.")
	validationResultOutcome: ValidationResultOutcome;

	@OpenAPI.extension("x-ms-identifiers", [])
	@doc("The details for each validation rule")
	validationResultDetails?: ValidationResultDetail[];
}

@doc("The detail of each SLZ validation.")
model ValidationResultDetail {
	@doc("The name of the validation result detail.")
	validationResultDetailName: string;

	@doc("The outcome of each validation rule.")
	validationResultDetailOutcome: validationResultDetailOutcome;

	@doc("The details about the outcome.")
	outcomeDescription: string;
}

@doc("The execution details")
model MonitorResult extends Result {
	@doc("The outcome of the monitor execution.")
	monitorResultOutcome?: MonitorResultOutcome;

	@doc("The percentage of monitor rules that is compliant.")
	compliancePercentage?: float64;

	@OpenAPI.extension("x-ms-identifiers", [])
	@doc("The result details for each monitor rule")
	monitorResultDetails?: MonitorResultDetail[];
}

@doc("The detail of an monitor execution")
model MonitorResultDetail {
	@doc("The name of the monitor rule.")
	monitorResultDetailName: string;

	@doc("The outcome of each policy monitor rule.")
	monitorRetailDetailOutcome: MonitorResultDetailOutcome;

	@doc("The details about the outcome.")
	outcomeDescription?: string;

	@doc("True if the outcome is for a policy set")
	isPolicySet: boolean;

	@doc("The name of the policy/policy set")
	policySetOrPolicyname: string;

	@doc("The type of the policy - builtin/custom")
	policyType?: PolicyType;
}

enum AlertChannel {
	Email: "Email",
	AzurePortal: "Azure Portal",
	AzureMonitor: "Azure Monitor",
}

@doc("The type of the policy.")
enum PolicyType {
	custom: "Custom",
	builtIn: "BuildIn",
}

@doc("the outcome of monitor execution")
enum MonitorResultOutcome {
	compliant: "Compliant",
	partiallyCompliant: "PartiallyCompliant",
	nonCompliant: "NonCompliant",
}

enum DetailOutcome {
	pass: "Pass",
	fail: "Fail",
}

@doc("the outcome of each monitor rule.")
enum MonitorResultDetailOutcome {
	...DetailOutcome,
}

@doc("the outcome of SLZ validation.")
enum SLZValidationStatus {
	...ValidationResultOutcome,
	validationNotStarted: "ValidationNotStarted",
	validationInProgress: "ValidationInProgress",
}

@doc("the outcome of SLZ validation.")
enum ValidationResultOutcome {
	validSLZ: "ValidSLZ",
	invalidSLZ: "InvalidSLZ",
}

@doc("the outcome of each monitor rule.")
enum validationResultDetailOutcome {
	...DetailOutcome,
}

@doc("the category of the policy monitor.")
enum MonitorCategory {
	locationPolicies,
	confidentialPolicies,
	generalPolicies,
}

enum validationOrMonitorHistoryStatus {
	draft: "Draft",
	inProgress: "InProgress",
	Completed: "Completed",
	failed: "Failed",
}

enum Status {
	active: "Active",
	inActive: "InActive",
}

enum ExclusionStatus {
	...Status,
}

enum MonitorStatus {
	...Status,
}

// Workaround suggested by the CADL team until the issue is fixed in their next sprint. Need to change the code once the fix is available.
@Azure.Core.pagedResult
@friendlyName("Paged{name}", TResource)
@doc("Paged collection of {name} items", TResource)
model Page<TResource extends object> {
	@doc("The {name} items on this page", TResource)
	@OpenAPI.extension("x-ms-identifiers", [])
	@Azure.Core.items
	value: TResource[];

	@doc("The link to the next page of items")
	@Azure.Core.nextLink
	nextLink?: string;
}

@doc("The response of getSLZValidationResult operation.")
@friendlyName("ValidationResultList")
// Workaround implemented. change to Azure.Core.Page once the fix is implemented by the CADL team
model ValidationResultList is Page<ValidationResult>;

@doc("The response of getPolicyMonitorExecutionResult operation.")
@friendlyName("MonitorResultList")
// Workaround implemented. change to Azure.Core.Page once the fix is implemented by the CADL team
model MonitorResultList is Page<MonitorResult>;
