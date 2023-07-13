import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Edge Device",
  version: "2023-07-15-privatepreview",
})
@doc("Azure Arc-enabled Edge Device.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureStackHCI;

@doc("Edge device resource")
model Device is ExtensionResource<DeviceProperties> {
  @doc("Name of Device")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("deviceName")
  @path
  @segment("device")
  name: string;
}

@doc("Device properties")
model DeviceProperties {

@doc("Configuration of device")
  deviceConfiguration: DeviceConfiguration;
  nodeMetadata: string;
}

@doc("The device Configuration of a device.")
model DeviceConfiguration {
  nicDetails: NicDetail[];
  dnsServers: dnsServers[];
  proxyConfiguration: ProxyConfiguration[];
  osVersion: string;
  managementNicDetails: ManagementNicDetail[];
}

@doc("The NicDetail of a device.")
model NicDetail {
  adapterName: string;
  componentId: string;
  driverVersion: string;
  interfaceDescription: string;
  @doc("ip adress of nic")
  @pattern("")
  ip4Address: string;
  subnetMask: string;
  defaultGateway: string;
}

@doc("The dnsServers of a device.")
model dnsServers {
  dnsServer: string;
}

@doc("The ProxyConfiguration of a device.")
model ProxyConfiguration {
  url: string;
  port: string;
}

@doc("The ManagementNicDetail of a device.")
model ManagementNicDetail {
  adapterName: string;
  defaultIsolationId: string;
  dnsServers: dnsServers[];
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is being deleted")
  Deleting,

  @doc("The resource create request has been accepted")
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface EdgeDevice {
  get is ArmResourceRead<Device>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Device>;
  update is ArmResourcePatchSync<Device, DeviceProperties>;
  delete is ArmResourceDeleteSync<Device>;
  listByResourceGroup is ArmResourceListByParent<Device>;
  listBySubscription is ArmListBySubscription<Device>;
}
