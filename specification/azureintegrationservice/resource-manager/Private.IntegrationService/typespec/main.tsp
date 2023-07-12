import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Private.IntegrationService")
@service({
	title: "Private.IntegrationService",
	version: "2023-06-01-preview",
})
@doc("The azure integration service resource provider.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.IntegrationService;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
	...ResourceProvisioningState,
	Provisioning,
	Updating,
	Deleting,
	Accepted,
}

@doc("The properties of space.")
model SpaceResourceProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;

	@doc("The description of the resource.")
	description?: string;
};

@doc("The properties of infrastructure resource.")
model InfrastructureResourceProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;

	@doc("The type of the infrastructure resource.")
	resourceType: string;

	@doc("The id of the infrastructure resource.")
	resourceId: string;
}

@doc("The properties of tracking data store.")
model TrackingDataStore {
	@doc("The database name.")
	databaseName: string;

	@doc("The data store resource id.")
	dataStoreResourceId: string;
}

@doc("The properties of application.")
model ApplicationProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;

	@doc("The description of the resource.")
	description?: string;

	@doc("The tracking data stores.")
	trackingDataStores: Record<TrackingDataStore>;
};

@doc("The properties of application resource.")
model ApplicationResourceProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;

	@doc("The type of the application resource.")
	resourceType: string;

	@doc("The Arm id of the application resource.")
	resourceId: string;

	@doc("The kind of the application resource.")
	resourceKind?: string;
}

@doc("The properties of business process.")
model BusinessProcessProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;

	@doc("The description of the business process.")
	description?: string;

	@doc("The draft business process.")
	draftBusinessProcess: object;

	@doc("The business process identifier.")
	identifier?: object;

	@doc("The business process stages.")
	businessProcessStages?: object;

	@doc("The business process mapping.")
	businessProcessMapping?: object;

	@doc("The tracking data store reference name.")
	trackingDataStoreReferenceName?: string;
}

// Space
@doc("An integration space.")
model Space is TrackedResource<SpaceResourceProperties> {
	@key("spaceName")
	@segment("spaces")
	@doc("The name of the space")
	@path
	@pattern("[a-zA-Z0-9_.()-]{0,79}$")
	name: string;
}

@armResourceOperations
@doc("The operations of space.")
interface Spaces {
	get is ArmResourceRead<Space>;
	create is ArmResourceCreateOrUpdateSync<Space>;
	update is ArmResourcePatchSync<Space, SpaceResourceProperties>;
	delete is ArmResourceDeleteSync<Space>;
	listBySubscription is ArmListBySubscription<Space>;
	listByResourceGroup is ArmResourceListByParent<
		Space,
		Azure.ResourceManager.Foundations.BaseParameters<Space> &
			Azure.Core.StandardListQueryParameters &
			Azure.Core.FilterQueryParameter &
			Azure.Core.SelectQueryParameter &
			Azure.Core.ExpandQueryParameter &
			Azure.Core.OrderByQueryParameter
	>;
}

// Infrastructure resource
@doc("An infrastructure resource under Space.")
@parentResource(Space)
model InfrastructureResource is ProxyResource<InfrastructureResourceProperties> {
	@key("infrastructureResourceName")
	@segment("infrastructureResources")
	@doc("The name of the infrastructure resource in the space.")
	@path
	@pattern("[a-zA-Z0-9_.()-]{0,79}$")
	name: string;
}

@armResourceOperations
@doc("The operations of the infrastructure resource.")
interface InfrastructureResources {
	get is ArmResourceRead<InfrastructureResource>;
	create is ArmResourceCreateOrUpdateSync<InfrastructureResource>;
	update is ArmResourcePatchSync<
		InfrastructureResource,
		InfrastructureResourceProperties
	>;
	delete is ArmResourceDeleteSync<InfrastructureResource>;
	listBySpace is ArmResourceListByParent<
		InfrastructureResource,
		Azure.ResourceManager.Foundations.BaseParameters<InfrastructureResource> &
			Azure.Core.StandardListQueryParameters &
			Azure.Core.FilterQueryParameter &
			Azure.Core.SelectQueryParameter &
			Azure.Core.ExpandQueryParameter &
			Azure.Core.OrderByQueryParameter
	>;
}

// Application
@doc("An integration application under space.")
@parentResource(Space)
model Application is TrackedResource<ApplicationProperties> {
	@key("applicationName")
	@segment("applications")
	@doc("The name of the Application")
	@path
	@pattern("[a-zA-Z0-9_.()-]{0,79}$")
	name: string;
}

@armResourceOperations
interface Applications {
	get is ArmResourceRead<Application>;
	create is ArmResourceCreateOrUpdateSync<Application>;
	update is ArmResourcePatchSync<Application, ApplicationProperties>;
	delete is ArmResourceDeleteSync<Application>;
	listBySpace is ArmResourceListByParent<
		Application,
		Azure.ResourceManager.Foundations.BaseParameters<Space> &
			Azure.Core.StandardListQueryParameters &
			Azure.Core.FilterQueryParameter &
			Azure.Core.SelectQueryParameter &
			Azure.Core.ExpandQueryParameter &
			Azure.Core.OrderByQueryParameter
	>;
}

// Application resource
@doc("A resource under application.")
@parentResource(Application)
model ApplicationResource is ProxyResource<ApplicationResourceProperties> {
	@key("resourceName")
	@segment("resources")
	@doc("The name of the application resource.")
	@path
	@pattern("[a-zA-Z0-9_.()-]{0,79}$")
	name: string;
}

@armResourceOperations
interface ApplicationResources {
	get is ArmResourceRead<ApplicationResource>;
	create is ArmResourceCreateOrUpdateSync<ApplicationResource>;
	update is ArmResourcePatchSync<
		ApplicationResource,
		ApplicationResourceProperties
	>;
	delete is ArmResourceDeleteSync<ApplicationResource>;
	listByApplication is ArmResourceListByParent<
		ApplicationResource,
		Azure.ResourceManager.Foundations.BaseParameters<ApplicationResource> &
			Azure.Core.StandardListQueryParameters &
			Azure.Core.FilterQueryParameter &
			Azure.Core.SelectQueryParameter &
			Azure.Core.ExpandQueryParameter &
			Azure.Core.OrderByQueryParameter
	>;
}

// Business Process
@doc("A business process under application.")
@parentResource(Application)
model BusinessProcess is ProxyResource<BusinessProcessProperties> {
	@key("businessProcessName")
	@segment("businessProcesses")
	@doc("The name of the business process")
	@path
	@pattern("[a-zA-Z0-9_.()-]{0,79}$")
	name: string;
}

@armResourceOperations
interface BusinessProcesses {
	get is ArmResourceRead<BusinessProcess>;
	create is ArmResourceCreateOrUpdateSync<BusinessProcess>;
	update is ArmResourcePatchSync<BusinessProcess, BusinessProcessProperties>;
	delete is ArmResourceDeleteSync<BusinessProcess>;
	listByApplication is ArmResourceListByParent<
		BusinessProcess,
		Azure.ResourceManager.Foundations.BaseParameters<BusinessProcess> &
			Azure.Core.StandardListQueryParameters &
			Azure.Core.FilterQueryParameter &
			Azure.Core.SelectQueryParameter &
			Azure.Core.ExpandQueryParameter &
			Azure.Core.OrderByQueryParameter
	>;
}
