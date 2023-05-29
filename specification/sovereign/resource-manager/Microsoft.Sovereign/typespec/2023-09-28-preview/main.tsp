import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./policyMonitorModels.tsp";
import "./landingZoneConfigurationModels.tsp";
import "./landingZoneModels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using OpenAPI;
using Autorest;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
	title: "Microsoft.Sovereign",
})
@versioned(Versions)
namespace Microsoft.Sovereign;

enum Versions {
	@useDependency(
		Azure.Core.Versions.v1_0_Preview_2,
		Azure.ResourceManager.Versions.v1_0_Preview_1
	)
	v2023_09_28_preview: "2023-09-28-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

// Landing Zone Configuration Resource Type
@tenantResource
@doc("A landing zone Configuration resource")
model LandingZoneConfiguration
	is ProxyResource<LandingZoneConfigurationProperties> {
	@doc("The name of the Landing Zone configuration resource type")
	@pattern("^[a-zA-Z0-9-]{3,24}$")
	@key("landingzoneconfigurationname")
	@segment("landingzoneconfigurations")
	@path
	name: string;
}

@armResourceOperations(LandingZoneConfiguration)
interface LandingZoneConfigurations
	extends TenantResourceOperations<
			LandingZoneConfiguration,
			LandingZoneConfigurationProperties
		> {
	@action("GenerateLandingZone")
	@doc("Generate the Sovereign Landing Zone")
	@armResourceAction(LandingZoneConfiguration)
	generateLandingZone is ArmResourceActionAsync<
		LandingZoneConfiguration,
		GenerateLandingZoneRequest,
		GenerateLandingZoneResponse
	>;

	@action("setPublishingStatus")
	@doc("Provides a mechanism to update the Publish Status")
	@armResourceAction(LandingZoneConfiguration)
	setPublishingStatus is ArmResourceActionNoContentSync<
		LandingZoneConfiguration,
		SetPublishStatusRequest
	>;
}

@tenantResource
@doc("A landing zone resource")
model LandingZone is ProxyResource<LandingZoneProperties> {
	@doc("The name of the Landing Zone resource type")
	@pattern("^[a-zA-Z0-9-]{3,24}$")
	@key("landingzonename")
	@segment("landingzones")
	@path
	name: string;
}

@armResourceOperations(LandingZone)
interface LandingZones
	extends TenantResourceOperations<LandingZone, LandingZoneProperties> {}

// Policy Monitor Resource Type
/*
@tenantResource
@doc("A policy monitor resource")
model PolicyMonitor is ProxyResource<PolicyMonitorProperties> {
	@doc("The name of the employee")
	@pattern("^[a-zA-Z0-9-]{3,24}$")
	@key("policymonitorname")
	@segment("policymonitors")
	@path
	name: string;
}

@armResourceOperations(PolicyMonitor)
interface PolicyMonitors
	extends TenantResourceOperations<PolicyMonitor, PolicyMonitorProperties> {
	@action("executeValidateSlz")
	@doc("Provides a mechanism for customers to trigger a validate of a particular SLZ instance")
	@armResourceAction(PolicyMonitor)
	executeValidateSlz is ArmResourceActionNoContentAsync<
		PolicyMonitor,
		ValidateRequest
	>;

	@action("executePolicyMonitor")
	@doc("Provides a mechanism for customers to trigger the evaluation policy monitor against an SLZ.")
	@armResourceAction(PolicyMonitor)
	executePolicyMonitor is ArmResourceActionNoContentAsync<
		PolicyMonitor,
		MonitorRequest
	>;

	//Should this be Data plane or Control plane
	@post
	@action("getPolicyMonitorExecutionResults")
	@doc("Returns the results of the policy monitor executions. By default the results of the last 50 executions will be returned.")
	@armResourceAction(PolicyMonitor)
	getPolicyMonitorExecutionResults(
		...ResourceInstanceParameters<
			PolicyMonitor,
			BaseParameters<PolicyMonitor>
		>
	): ArmResponse<MonitorResultList> | ErrorResponse;

	//Should this be Data plane or Control plane
	@post
	@action("getSlzValidationResults")
	@doc("Returns the results of the SLZ Validation. By default the results of the last 50 executions will be returned.")
	@armResourceAction(PolicyMonitor)
	getSlzValidationResults(
		...ResourceInstanceParameters<
			PolicyMonitor,
			BaseParameters<PolicyMonitor>
		>
	): ArmResponse<ValidationResultList> | ErrorResponse;
}
*/