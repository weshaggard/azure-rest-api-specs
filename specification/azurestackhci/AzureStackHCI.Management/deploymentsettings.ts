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
  title: "Deployment Settings",
  version: "2023-07-15-privatepreview",
})
@doc("Azure Stack HCI Deployment Settings.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureStackHCI;

@doc("A Cluster")
model Clusters is TrackedResource<ClusterProperties> {
  @key("clusterName")
  @doc("Name of Cluster")
  @segment("clusters")
  name: string;
}

@doc("A ClusterProperties")
model ClusterProperties {
}

@doc("Edge device resource")
@parentResource(Clusters)
model DeploymentSetting is ProxyResource<DeploymentSettingProperties> {
  @doc("Name of Deployment Setting")
  @segment("deploymentSettings")
  @key("default")
  @path
  name: string
}

@doc("DeploymentSetting properties")
model DeploymentSettingProperties {
  @doc("Todo")
  provisioningState: ProvisioningState,
  @doc("Todo")
  deploymentData: DeploymentData,
  @doc("Todo")
  deploymentMetaData: DeploymentMetaData;
  
}

@doc("The DeploymentData of AzureStackHCI Cluster.")
@externalDocs("https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-tool-existing-file", 
"Deploy Azure Stack HCI using an existing configuration file")
model DeploymentData {
  @doc("ToDo")
  securitySettings: SecuritySettings,
  @doc("ToDo")
  observability: Observability,
  @doc("ToDo")
  cluster: Cluster,
  @doc("ToDo")
  storage: Storage,
  @doc("ToDo")
  namingPrefix : string,
  @doc("ToDo")
  domainFQDN: string,
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  infrastructureNetwork: InfrastructureNetwork[],
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  physicalNodes : PhysicalNodes[],
  @doc("ToDo")
  "hostNetwork" : HostNetwork,
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  "storageNetworks": StorageNetworks[],
  @doc("ToDo")
  "adouPath" : string,
  @doc("ToDo")
  @extension("x-ms-secret", true)
  secretsLocation : url,
  @doc("ToDo")
  optionalServices: OptionalServices
}

@doc("The DeploymentMetaData of AzureStackHCI Cluster.")
model DeploymentMetaData {
}

@doc("The DeploymentStatus of AzureStackHCI Cluster.")
model RepoertedProperties {
  @doc("ToDo")
  @visibility("read")
  validatonStatus : ValidationStatus,
  @doc("ToDo")
  @visibility("read")
  deploymentStatus: DeploymentStatus
}


@doc("The ValidationStatus of AzureStackHCI Cluster.")
model ValidationStatus {
  // ToDo add desc for each param
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  action: Action[]
}

@doc("The DeploymentStatus of AzureStackHCI Cluster.")
model DeploymentStatus {
  // ToDo add desc for each param
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  action: Action[]
}

@doc("The Action of AzureStackHCI Cluster.")
model Action {
  // ToDo add desc for each param
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  steps: Step[],
  @doc("ToDo")
  @visibility("read")
  type: string,
  @doc("ToDo")
  @visibility("read")
  startTime: utcDateTime,
  @doc("ToDo")
  @visibility("read")
  endTime: utcDateTime,
  @doc("ToDo")
  @visibility("read")
  status: Status,
}

@doc("The Step of AzureStackHCI Cluster.")
model Step {
  // ToDo add desc 
  @doc("ToDo")
  @visibility("read")
  name: string,
  @doc("ToDo")
  @visibility("read")
  description: string,
  @doc("isRequired?")
  @visibility("read")
  index: integer,
   @doc("isRequired?")
   @visibility("read")
  fullStepIndex: string,
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  task: Task[],
  @doc("ToDo")
  @visibility("read")
  startTime: utcDateTime,
  @doc("ToDo")
  @visibility("read")
  endTime: utcDateTime,
  @doc("ToDo")
  @visibility("read")
  status: Status,
}

@doc("The Step of AzureStackHCI Cluster.")
model Task {
  // ToDo add desc for each param
  @doc("ToDo")
  @visibility("read")
  evaluation: Evaluation,
  @doc("ToDo")
  @visibility("read")
  exception: Exception,
  @doc("ToDo")
  @visibility("read")
  rolePath: string,
  @doc("ToDo")
  @visibility("read")
  interfaceType: string,
  @doc("ToDo")
  @visibility("read")
  startTime: utcDateTime,
  @doc("ToDo")
  @visibility("read")
  endTime: utcDateTime,
  @doc("ToDo")
  @visibility("read")
  status: Status,
}

@doc("The Exception of AzureStackHCI Cluster.")
model Exception {
  // ToDo add desc for each param
  @doc("ToDo")
  @visibility("read")
  message: string,
  @doc("ToDo")
  @visibility("read")
  machineName: string
}

@doc("The Evaluation of AzureStackHCI Cluster.")
model Evaluation {
  // ToDo add desc for each param
  @doc("ToDo")
  @visibility("read")
  message: string
}


@doc("The SecuritySettings of AzureStackHCI Cluster.")
model SecuritySettings {
  // ToDo add desc for each param
  @doc("ToDo")
  hvciProtection: boolean = true,
  @doc("ToDo")
  drtmProtection: boolean = true,
  @doc("ToDo")
  driftControlEnforced: boolean = true,
  @doc("ToDo")
  credentialGuardEnforced: boolean = false,
  @doc("ToDo")
  smbSigningEnforced: boolean = true,
  @doc("ToDo")
  smbClusterEncryption: boolean = false,
  @doc("ToDo")
  sideChannelMitigationEnforced: boolean = true,
  @doc("ToDo")
  bitlockerBootVolume: boolean = true,
  @doc("ToDo")
  bitlockerDataVolumes: boolean = true,
  @doc("ToDo")
  wdacEnforced: boolean = true
}

@doc("The Observability of AzureStackHCI Cluster.")
model Observability {
  // ToDo add desc for each param
  @doc("ToDo")
  streamingDataClient: boolean = true,
  @doc("ToDo")
  euLocation: boolean = false,
  @doc("ToDo")
  episodicDataUpload: boolean = true,
}

@doc("The OptionalServices of AzureStackHCI Cluster.")
model OptionalServices {
  // ToDo add desc for each param
  @doc("ToDo")
  virtualSwitchName: string,
  @doc("ToDo")
  csvPath: string,
  @doc("ToDo")
  arbRegion: string,
}

@doc("The Cluster of AzureStackHCI Cluster.")
model Cluster {
  // ToDo add desc for each param
  @doc("ToDo")
  name: string,
  @doc("ToDo")
  witnessType: WitnessType,
  @doc("ToDo")
  witnessPath: string,
  @doc("ToDo")
  cloudAccountName: string,
  @doc("ToDo")
  azureServiceEndpoint: string
}

@doc("The Cluster of AzureStackHCI Cluster.")
model Storage {
  // ToDo add desc for each param
  @doc("ToDo")
  "configurationMode": ConfigurationMode = ConfigurationMode.Express
}


@doc("The InfrastructureNetwork of a cluster.")
model InfrastructureNetwork {
  @doc("ToDo")
  vlanId: string,
  @doc("ToDo")
  subnetMask: string,
  @doc("ToDo")
  gateway: string,
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  ipPools: IpPools[],
  @doc("ToDo")
  dnsServers: string[]
}

@doc("The PhysicalNodes of a cluster.")
model PhysicalNodes {
  @doc("ToDo")
  name: string,
  @doc("ToDo")
  ipv4Address: string,
}

@doc("The dnsServers of a device.")
model IpPools {
   @doc("ToDo")
  startingAddress: string,
   @doc("ToDo")
  endingAddress: string,
}

@doc("The HostNetwork of a cluster.")
model HostNetwork {
  @doc("ToDo")
  @extension("x-ms-identifiers", [])
  intents: Intents[]
}

@doc("The Intents of a cluster.")
model Intents {
  @doc("ToDo")
  name: string,
  @doc("ToDo")
  trafficType: TrafficType[],
  @doc("ToDo")
  adapter: string[],
  @doc("ToDo")
  overrideVirtualSwitchConfiguration: boolean = false,
  @doc("ToDo")
  virtualSwitchConfigurationOverrides: VirtualSwitchConfigurationOverrides,
  @doc("ToDo")
  overrideQosPolicy: boolean = false,
  @doc("ToDo")
  qosPolicyOverrides: QosPolicyOverrides,
  @doc("ToDo")
  overrideAdapterProperty: boolean = false,
  @doc("ToDo")
  adapterPropertyOverrides: AdapterPropertyOverrides,
}

@doc("The StorageNetworks of a cluster.")
model StorageNetworks {
  @doc("ToDo")
  name: string,
  @doc("ToDo")
  networkAdapterName: string,
  @doc("ToDo")
  vlanId: string
}

@doc("The VirtualSwitchConfigurationOverrides of a cluster.")
model VirtualSwitchConfigurationOverrides {
  @doc("ToDo")
  enableIov: string,
  @doc("ToDo")
  loadBalancingAlgorithm: string
}

@doc("The QoSPolicyOverrides of a cluster.")
model QosPolicyOverrides {
  @doc("ToDo")
  priorityValue8021Action_Cluster: string,
  @doc("ToDo")
  priorityValue8021Action_SMB: string,
  @doc("ToDo")
  bandwidthPercentage_SMB: string
}

@doc("The AdapterPropertyOverrides of a cluster.")
model AdapterPropertyOverrides {
  @doc("ToDo")
  jumboPacket: string,
  @doc("ToDo")
  networkDirect: string,
  @doc("ToDo")
  networkDirectTechnology: string
}

@doc("The ConfigurationMode of a resource.")
enum ConfigurationMode {
  @doc("Todo")
  Express,
}

@doc("The TrafficType of a resource.")
enum Status {
  @doc("Error")
  Error,
  @doc("Success")
  Success,
  @doc("InProgress")
  InProgress
}

@doc("The TrafficType of a resource.")
enum TrafficType {
  @doc("Compute")
  Compute,
  @doc("Management")
  Management,
  @doc("Storage")
  Storage
}

@doc("The WitnessType of a resource.")
enum WitnessType {
  @doc("Cloud")
  Cloud,

  @doc("FileShare")
  FileShare,
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





@doc("The DeploymentChangeRequest of a resource.")
enum DeploymentChangeRequest {
  @doc("ValidateOnly")
  ValidateOnly,

  @doc("Deploy")
  Deploy,

  @doc("ValidateAndDeployIfSuccess")
  ValidateAndDeployIfSuccess,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface DeploymentSettings {
  get is ArmResourceRead<DeploymentSetting>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeploymentSetting>;
  update is ArmResourcePatchAsync<DeploymentSetting, DeploymentSettingProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DeploymentSetting>;
  listByParent is ArmResourceListByParent<DeploymentSetting>;
  deploy is ArmResourceActionAsync<DeploymentSetting, DeployRequest, DeployResponse>;
}

@doc("The deployRequest of a cluster.")
model DeployRequest{
  @doc("ToDo")
  deploymentChangeRequest: DeploymentChangeRequest
}

@doc("An Accepted response with an Operation-Location header.")
model DeployResponse{
  @doc("The status code.")
  @statusCode
  statusCode: 202;
}
