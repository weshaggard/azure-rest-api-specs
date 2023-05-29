using Azure.ResourceManager;

/*
The provisioning status of the Resource. The current status are listed below -
  Succeeded,
  Failed,
  Canceled,
*/
@doc("The status of the policy monitor operations.")
enum ProvisioningState {
	...ResourceProvisioningState,
}