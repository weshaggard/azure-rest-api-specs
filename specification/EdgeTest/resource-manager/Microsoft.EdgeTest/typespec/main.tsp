import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Autorest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Microsoft.EdgeTest")
@service({
  title: "Microsoft.EdgeTest",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.EdgeTest;

interface Operations extends Azure.ResourceManager.Operations {}

// Root-level tracked resource: provisioning resource
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning resource")
model ProvisioningResource is TrackedResource<ProvisioningResourceProperties> {
  @doc("The name of the employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("provisioningResourceName")
  @segment("provisioningResources")
  @path
  name: string;

  // TODO resource SKU @Jesus to define
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The activating state")
  Activating,

  @doc("The updating state")
  Updating,

  @doc("The deleting state")
  Deleting,
}

@doc("Details of the EdgeProvisioning ProvisioningResource.")
model ProvisioningResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("The provisioning service endpoints")
  deviceEndpoints?: DeviceEndpoints;
}

@doc("Device endpoints.")
model DeviceEndpoints { // TODO: follow up with DP and PM on the definition of the endpoints for ignite
  @doc("The default endpoint")
  default: DeviceEndpoint,
}

@doc("The device endpoint")
model DeviceEndpoint {
  @doc("Description of the Endpoint")
  @visibility("read")
  description?: string;

  @doc("Hostname of the Endpoint")
  @visibility("read")
  hostname?: string;
}

@doc("Resource create or update operation completed successfully.")
model ResourceUpdatedResponse<T> is ArmResponse<T> {
}

@armResourceOperations
interface EdgeProvisioningOpeartions {
  @autoRoute
  @doc("Create a {name}", TResource)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @armResourceCreateOrUpdate(TResource)
  @put
  op EdgeProvisioningResourceCreateOrUpdateAsync<
    TResource extends ArmResource,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,

    @doc("Resource create parameters.")
    @body
    resource: TResource,
  ): ResourceUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;
}

@armResourceOperations
interface ProvisioningResources {
  get is ArmResourceRead<ProvisioningResource>;
  createOrUpdate is EdgeProvisioningOpeartions.EdgeProvisioningResourceCreateOrUpdateAsync<ProvisioningResource>;
  delete is ArmResourceDeleteSync<ProvisioningResource>;
  update is ArmResourcePatchSync<ProvisioningResource, ProvisioningResourceProperties>;
  listByResourceGroup is ArmResourceListByParent<ProvisioningResource>;
  listBySubscription is ArmListBySubscription<ProvisioningResource>;
}

// Child resource: provisioning policy
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning policy resource")
@parentResource(ProvisioningResource)
model ProvisioningPolicy is TrackedResource<ProvisioningPolicyProperties> {
  @doc("The name of the employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("provisioningPolicyName")
  @segment("provisioningPolicies")
  @path
  name: string;
}

@doc("Details of the ProvisioningService ProvisioningPolicy.")
model ProvisioningPolicyProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The priority of the policy. Should be greater than 0.")
  priority: int32; 
  // TODO: is priority required property. 
  // can we avoid requirement for uniquenes
  // how can the customer swap priority for policies 
  // alternate option1: Consider Provisioning Policy properties as an array
  // alternate option2: Keep the priority as separate concept outside of policy
  // Investigate options from other resources

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication: BootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @extension("x-ms-identifiers", ["name"])
  allocations?: Array<AllocationRule>;

  @doc("The device provisioning rule.")
  provisioning: ProvisioningRule;
}

@doc("The authentication type for bootstrap.")
enum BootstrapAuthenticationType {
  @doc("The X509 authentication type.")
  X509,

  @doc("The discovery authentication type.")
  Discovery,
}

@doc("The authentication details for bootstrap")
model BootstrapAuthenticationDetails {
  @doc("The primary certificate")
  @secret
  primaryCertificate: string;

  @doc("The secondary certificate")
  @secret
  secondaryCertificate?: string;
}

@doc("The authentication rule for bootstrap")
model BootstrapAuthenticationRule {
  @doc("The type of authentication rule")
  type: BootstrapAuthenticationType;

  @doc("The authentication details")
  details?: BootstrapAuthenticationDetails;
  // TODO use discriminator for properties specific to a bootstrap auth type
}

@doc("Type of resource being provisioned")
enum ProvisioningResourceType {
  @doc("Azure device registry device")
  AzureIoTDevice,

  @doc("Arc enabled device.")
  ArcEnabledDevice,
}

@doc("The rule for Just-in-time connection")
model JitRule {
  @minLength(1)
  @doc("The region")
  region: string; // TODO: checkout the location resource and see if we can use it here

  //...SubscriptionIdParameter;
  @minLength(1)
  @doc("The ID of the target subscription.")
  subscriptionId: string;

  //...ResourceGroupParameter;
  @minLength(1)
  @maxLength(90)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @doc("The name of the resource group. The name is case insensitive.")
  resourceGroupName: string;
}

@doc("Type of the endpoint")
enum EndpointType {
  @doc("Azure event grid broker")
  AzureEventGridBroker,

  //@doc("Azure storage")
  //AzureStorage,
}

@doc("Type of allocation rule")
enum AllocationType {
  @doc("Static allocation of a single endpoint.")
  Static,

  @doc("Allocation based on geo-location.")
  GeoBased,

  @doc("Allocation based on weight.")
  Weighted,
}

@doc("The allocation rule")
@discriminator("type")
model AllocationRule {
  @doc("Name of the allocation rule")
  name: string;

  @doc("Type of endpoint")
  endpointType: EndpointType;

  @doc("Type of the allocation rule")
  type: AllocationType;
}

@doc("GeoBased allocation endpoint")
model GeoBasedAllocationEndpoint {
  @doc("Name of the endpoint")
  name: string;

  @doc("Resource id of the endpoint")
  resourceId: string;

  @doc("Region of the endpoint")
  region: string;
}

@doc("Weighted allocation endpoint")
model WeightedAllocationEndpoint {
  @doc("Name of the endpoint")
  name: string;

  @doc("Resource id of the endpoint")
  resourceId: string;

  @doc("Weight of the endpoint")
  weight: float64;
}

@doc("Static allocation endpoint")
model StaticAllocationEndpoint {
  @doc("Name of the endpoint")
  name: string;

  @doc("Resource id of the endpoint")
  resourceId: string;
}

@doc("The allocation rule for geoBased allocation type")
model GeoBasedAllocationRule extends AllocationRule {
  @doc("GeoBased allocation type")
  type: AllocationType.GeoBased;

  @doc("List of endpoints for geoBased allocation type")
  @maxItems(50)
  @extension("x-ms-identifiers", ["name"])
  endpoints?: Array<GeoBasedAllocationEndpoint>;
}

@doc("The allocation rule for weighted allocation type")
model WeightedAllocationRule extends AllocationRule {
  @doc("weighted allocation type")
  type: AllocationType.Weighted;

  @doc("List of endpoints for weighted allocation type")
  @maxItems(50)
  @extension("x-ms-identifiers", ["name"])
  endpoints?: Array<WeightedAllocationEndpoint>;
}

@doc("The allocation rule for static allocation type")
model StaticAllocationRule extends AllocationRule {
  @doc("Static allocation type")
  type: AllocationType.Static;

  @doc("List of endpoints for static allocation type")
  @maxItems(50)
  @extension("x-ms-identifiers", ["name"])
  endpoints?: Array<StaticAllocationEndpoint>;
}

@doc("The identity info to return to device")
model DeviceIdentityInfo {
  @doc("If uuid need to be returned")
  uuid: boolean;

  @doc("If accessTokenUrl need to be returned")
  accessTokenUrl: boolean;

  @doc("If externalDeviceId need to be returned")
  externalDeviceId: boolean;
}

@doc("Potential sources for cert issuance config")
enum SourceType {
  @doc("From certificate signing request")
  CSR,

  @doc("From the enrollment policy")
  Policy,

  @doc("From the substitute")
  Substitute
}

@doc("Supported key types")
enum SupportedKeyType {
  @doc("RSA")
  RSA,

  @doc("EC")
  EC,
}

@doc("Supported extended key usages")
enum SupportedExtendedKeyUsage {
  @doc("Client auth")
  ClientAuth,

  @doc("Code signing")
  CodeSigning,

  @doc("Email protection")
  EmailProtection,

  @doc("Ipsec end system")
  IpsecEndSystem,

  @doc("Ipsec tunnel")
  IpsecTunnel,

  @doc("Ipsec user")
  IpsecUser,

  @doc("Mac address")
  MacAddress,

  @doc("Ocsp signing")
  OcspSigning,

  @doc("Server auth")
  ServerAuth,

  @doc("Smartcard logon")
  SmartcardLogon,

  @doc("Time stamping")
  TimeStamping
}

@doc("Supported curve types")
enum SupportedCurveType {
  @doc("NistP256")
  NistP256,

  @doc("NistP384")
  NistP384,

  @doc("NistP521")
  NistP521,

  @doc("Secp256K1")
  Secp256K1,
}

@doc("Supported issusing authority")
enum SupportedIssuingAuthority {
  @doc("First party cert issuance")
  FirstParty
}

@doc("The configuration for setting up a CA")
model CaConfig
{
  @doc("Name of the CA")
  name: string;

  @doc("Certificate properties")
  properties: CertificateProperties;
}

@doc("Certificate properties")
@discriminator("keyType")
model CertificateProperties
{
  @doc("Key type: RSA or EC")
  keyType: SupportedKeyType;

  @doc("Certificate subject")
  subject: string;

  @doc("Certificate is valid not before this date")
  validityNotBefore: utcDateTime;

  @doc("Certificate is valid not after this date")
  validityNotAfter: utcDateTime;

  @doc("Extended key usage")
  extendedKeyUsage?: Array<SupportedExtendedKeyUsage>;
}

@doc("Certificate properties for RSA")
model CertificatePropertiesRSA extends CertificateProperties
{
  @doc("RSA Key type")
  keyType: SupportedKeyType.RSA;

  @doc("Key size for RSA key type")
  keySize: int32;
}

@doc("Certificate properties for EC")
model CertificatePropertiesEC extends CertificateProperties
{
  @doc("EC Key type")
  keyType: SupportedKeyType.EC;

  @doc("Curve type of EC")
  curveType: SupportedCurveType;
}

@doc("The configuration for setting up a policy")
model CertPolicyConfig
{
  @doc("The validity period")
  validityPeriod: ValidityPeriod;
}

@doc("The validity period for an enrollment policy")
model ValidityPeriod
{
  @doc("Source of the value")
  source: SourceType;

  @doc("Skew in minutes to account for the time on different computers not being in sync")
  notBeforeSkewMinutes: int32;

  @doc("For calculation of the NotBefore date")
  valueNotBeforeOffSetDays?: int32;

  @doc("For calculation of the NotAfter date")
  valueValidityPeriodDays?: int32,

  @doc("Allowed not before offset in days")
  allowedNotBeforeOffSetDays?: int32;

  @doc("Allowed validity period in days")
  allowedValidityPeriodDays?: int32;
}

@doc("Certificate issuance configurations")
model CertificateIssuanceRule {
  @doc("The type of authority for cert issuance")
  issuingAuthority: SupportedIssuingAuthority; //enum, FirstPartyPKI, BYO

  @doc("The configuration to set up an ICA")
  certificateAuthorityConfiguration: CaConfig; // set by the customers

  @doc("The enrollment policy configuration")
  certificatePolicyConfiguration: CertPolicyConfig; // same type as the ica config

  @doc("Cert renewal interval")
  renewalInterval: int32; // A number of percentage. An example for renewal interval is - renew at 80%
}

@doc("The information related to device identity")
model IdentityInfo {
  @doc("Certificate issuance settings")
  certificateIssuance?: CertificateIssuanceRule; // For PKI

  @doc("Device template id")
  deviceTemplateId?: string;

  @doc("AAD group name for static group")
  staticGroup?: string;

  @doc("The identity info to return to device")
  identityInfoForDevice?: DeviceIdentityInfo; // TODO check with Adarsh,Sekhar if this supports both HCI and ADR scenario
}

@doc("The provisioning rule")
model ProvisioningRule {
  @doc("Type of the resource being provisioned")
  type: ProvisioningResourceType;

  @doc("Just-in-time rule to create the device resource.")
  jit?: JitRule;

  @doc("Identity information")
  operationalIdentityInfo?: IdentityInfo; 

  @doc("Resource metadata")
  @maxLength(200)
  resourceMetadata?: string; // for customer to label the devices
}

@armResourceOperations
interface ProvisioningPolicies {
  get is ArmResourceRead<ProvisioningPolicy>;
  createOrUpdate is EdgeProvisioningOpeartions.EdgeProvisioningResourceCreateOrUpdateAsync<ProvisioningPolicy>;
  delete is ArmResourceDeleteSync<ProvisioningPolicy>;
  update is ArmResourcePatchSync<ProvisioningPolicy, ProvisioningPolicyProperties>;
  listByParent is ArmResourceListByParent<ProvisioningPolicy>;
}

// Extension resource: device provisioning state

// define extension resource scope in swagger via api path
// Roopesh to share the link for sample swagger
@doc("The provisioning state of a device.")
model DeviceProvisioningState is ExtensionResource<DeviceProvisioningStateProperties> {
  @doc("Singleton pattern using name: current.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("deviceProvisioningStateName")
  @segment("deviceProvisioningStates")
  @path
  name: string;
}

scalar ProvisioningPolicyResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.EdgeProvisioningService/ProvisioningResources/ProvisioningPolicies",
    }
  ]>;

@doc("Details of the DeviceProvisioningState")
model DeviceProvisioningStateProperties {
  @doc("Unique identifier for the device")
  registrationId: string;

  @visibility("read", "create", "update")
  @doc("Provisioning status of the resource this DeviceProvisioningState extends")
  status: ProvisioningStatus;

  @doc("Indicates if the device is enabled for discovery")
  discoveryEnabled: boolean;

  @doc("The provisioning policy resource id")
  provisioningPolicyResourceId?: ProvisioningPolicyResourceId;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The current provisioning status.")
enum ProvisioningStatus {
  @doc("Provisioning is still pending")
  Pending,
  @doc("The resource has been provisioned")
  Provisioned,
  @doc("Provisioning has failed")
  Failed
}

@armResourceOperations
interface DeviceProvisioningStates {
  get is ArmResourceRead<DeviceProvisioningState>;
  createOrUpdate is EdgeProvisioningOpeartions.EdgeProvisioningResourceCreateOrUpdateAsync<DeviceProvisioningState>;
  delete is ArmResourceDeleteSync<DeviceProvisioningState>;
  update is ArmResourcePatchSync<DeviceProvisioningState, DeviceProvisioningStateProperties>;
  listByParent is ArmResourceListByParent<DeviceProvisioningState>;
  listBySubscription is ArmListBySubscription<DeviceProvisioningState>;
}