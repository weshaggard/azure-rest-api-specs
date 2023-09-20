import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.Core.Traits;

@armProviderNamespace("Microsoft.EnterpriseSupport")
@service({
  title: "Microsoft ESRP",
  version: "2023-05-01-preview",
  summary: "Microsoft Enterprise Support Resource Provider"
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace Microsoft.EnterpriseSupport;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A ESRPProviderHub resource")
model EnterpriseSupports is TrackedResource<EnterpriseSupportsResponseProperties> {
	@doc("The name of the  Enterprise Support")
	@pattern("^[a-zA-Z0-9-]{3,24}$")
	@key("EnterpriseSupportName")
	@segment("EnterpriseSupports")
	@path
	name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
	...ResourceProvisioningState,
	Provisioning,
	Updating,
	Deleting,
	Accepted,
	Deleted
}

@doc("Details of the ESRP EnterpriseSupport.")
model EnterpriseSupportsResponseProperties {
	@doc("Provisioning status")
	provisioningState?: ProvisioningState;

	@doc("Billing Account ID")
	billingAccountId: string;

	@doc("Billing Group ID")
	billingGroupId: string;

	@doc("Invoice section for the billing account")
	projectId: string;

	@doc("BicCat product ID")
	productId: string;

	@doc("BigCat SKU ID")
	skuId: string;

	@doc("BigCat availability ID")
	availabilityId: string;

	@doc("BigCat Term ID")
	termId: string;

	@doc("Quantity for the purchase")
	quantity: integer;

	@doc("Service start date for  Enterprise Support")
	serviceStartDate: utcDateTime;

	@doc("CSAM for the  Enterprise Support")
	csam: string;

	@doc("Product UPN")
	upn: string;
}

@armResourceOperations
interface EnterpriseSupportsResource extends TrackedResourceOperations<EnterpriseSupports, EnterpriseSupportsResponseProperties> {
}

@doc("The request for an eligibility check.")
model ValidateEnterpriseSupportRequestItem {
	@doc("The array of line items to be validated")
	lineItems: Array<LineItem>;
}

@doc("The item to be validated.")
model LineItem {
	@doc("The purchasing scope")
	scope: string;

	@doc("The upn of a product.")
	upn: string;

	@doc("The quantity for this purchase")
	quantity: integer;
}

@doc("The response for an eligibility check.")
model ValidateEnterpriseSupportResponse {
	@doc("The array of line item validations.")
	lineItems: Array<ValidateEnterpriseSupportResponseItem>;
}

@doc("The item for an eligibility check.")
model ValidateEnterpriseSupportResponseItem {
	@doc("The purchasing scope")
	scope: string;

	@doc("The upn of a product.")
	upn: string;

	@doc("The quantity for this purchase")
	quantity: integer;

	@doc("Possible values are: eligible, ineligible and undetermined")
	isEligible: string;

	@doc("String reason for isEligible")
	reason: string;

	@doc("Code reason for isEligible")
	reasonCode: integer;
}


@autoRoute
@armResourceOperations
interface ProviderLevelOperations {
    @post
	@doc("ProviderLevel operation to check eligibility to create Enterprise Support")
    @segment("providers/Microsoft.EnterpriseSupport/validate")
    validate(@body body: ValidateEnterpriseSupportRequestItem): ArmResponse<ValidateEnterpriseSupportResponse>;
}
