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
using OpenAPI;

@armProviderNamespace
@service({
  title: "Edge Devices",
  version: "2023-08-01-preview",
})
@doc("Azure Arc-enabled Edge Device.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureStackHCI;

@doc("Edge device resource")
model EdgeDevice is ExtensionResource<EdgeDeviceProperties> {
  @doc("Name of Device")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("default")
  @path
  @segment("edgeDevices")
  name: string;
}

@doc("Edge Device properties")
model EdgeDeviceProperties {
  @doc("Device Configuration")
  deviceConfiguration: DeviceConfiguration;
  @doc("Device Metadata")
  deviceMetadata: string;
  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState: ProvisioningState
}

@doc("The device Configuration of a device.")
model DeviceConfiguration {
  @doc("NIC Details of device")
  @extension("x-ms-identifiers", [])
  nicDetails: NicDetail[];
  @doc("DNS Server Details of device")
  @extension("x-ms-identifiers", [])
  dnsServers: string[];
  @doc("ProxyConfiguration Details of device")
  @extension("x-ms-identifiers", [])
  proxyConfiguration: ProxyConfiguration[];
  @doc("OS Version of device")
  osVersion: string;
  @doc("Management NIC Details of device")
  @extension("x-ms-identifiers", [])
  managementNicDetails: ManagementNicDetail[];
}

@doc("The NIC Detail of a device.")
model NicDetail {
  @doc("Adapter Name of NIC")
  adapterName: string;
  @doc("Component Id of NIC")
  componentId: string;
  @doc("Driver Version of NIC")
  driverVersion: string;
  @doc("Interface Description of NIC")
  interfaceDescription: string;
  @doc("Subnet Mask of NIC")
  ip4Address: string;
  @doc("Subnet Mask of NIC")
  subnetMask: string;
  @doc("Default Gateway of NIC")
  defaultGateway: string;
}

@doc("The ProxyConfiguration of a device.")
model ProxyConfiguration {
  @doc("Proxy URL of device")
  url: string;
  @doc("Proxy Port of device")
  port: string;
}

@doc("The Management NIC Detail of a device.")
model ManagementNicDetail {
   @doc("Adapter Name of Management NIC")
  adapterName: string;
  @doc("Default Isolation of Management NIC")
  defaultIsolationId: string;
  @doc("DNS Servers of Management NIC")
  dnsServers: string[];
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
interface EdgeDevices {
  get is ArmResourceRead<EdgeDevice>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeDevice>;
  update is ArmResourcePatchSync<EdgeDevice, EdgeDeviceProperties>;
  delete is ArmResourceDeleteSync<EdgeDevice>;
}