import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./policyMonitorModels.tsp";

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
	title: "Cloud for Sovereignty Resource Provider.",
	version: "2023-04-01-privatepreview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Sovereign;

interface Operations extends Azure.ResourceManager.Operations {}

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
	@action("executeValidateSLZ")
	@doc("Provides a mechanism for customers to trigger a validate of a particular SLZ instance")
	@armResourceAction(PolicyMonitor)
	validateSLZ is ArmResourceActionAsync<
		PolicyMonitor,
		ValidateRequest,
		ValidateRequest
	>;

	@action("executePolicyMonitor")
	@doc("Provides a mechanism for customers to trigger the evaluation policy monitor against an SLZ.")
	@armResourceAction(PolicyMonitor)
	monitorSLZ is ArmResourceActionAsync<
		PolicyMonitor,
		MonitorRequest,
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
	@action("getSLZValidationResults")
	@doc("Returns the results of the SLZ Validation. By default the results of the last 50 executions will be returned.")
	@armResourceAction(PolicyMonitor)
	getSLZValidationResults(
		...ResourceInstanceParameters<
			PolicyMonitor,
			BaseParameters<PolicyMonitor>
		>
	): ArmResponse<ValidationResultList> | ErrorResponse;
}
