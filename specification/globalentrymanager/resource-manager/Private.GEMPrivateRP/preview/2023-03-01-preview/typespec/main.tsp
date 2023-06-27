import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Private.GEMPrivateRP",
  version: "2023-03-01-preview",
})
@doc("Global Entry Manager Management API")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.GEMPrivateRP;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Global Entry Manager Resource")
model GlobalEntryManagerResource is TrackedResource<GlobalEntryManagerProperties> {
  @doc("The name of the Global Entry Manager")
  @key("globalEntryManagerName")
  @segment("globalEntryManagers")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
  ...EntityTag;
}

@doc("A Global Entry Profile Resource")
@parentResource(GlobalEntryManagerResource)
model EntryProfileResource is TrackedResource<EntryProfileProperties> {
  @doc("The name of the Global Entry Profile")
  @key("entryProfileName")
  @segment("entryProfiles")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
  ...EntityTag;
}

@doc("A Global Entry Profile Rule Resource")
@parentResource(EntryProfileResource)
model EntryProfileRuleResource is TrackedResource<EntryProfileRuleProperties> {
  @doc("The name of the Global Entry Profile Rule")
  @key("entryProfileRuleName")
  @segment("entryProfileRules")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
  ...EntityTag;
}

@doc("A Global Entry Region Resource")
@parentResource(GlobalEntryManagerResource)
model EntryRegionResource is TrackedResource<EntryRegionProperties> {
  @doc("The name of the Global Entry Region")
  @key("entryRegionName")
  @segment("entryRegions")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
  ...EntityTag;
}

@doc("A Global Entry Link Resource")
@parentResource(GlobalEntryManagerResource)
model EntryLinkResource is TrackedResource<EntryLinkProperties> {
  @doc("The name of the Global Entry Link")
  @key("entryLinkName")
  @segment("entryLinks")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
  ...EntityTag;
}

@armResourceOperations
interface GlobalEntryManager {
  get is ArmResourceRead<GlobalEntryManagerResource>;
  create is ArmResourceCreateOrUpdateAsync<GlobalEntryManagerResource>;
  update is ArmResourcePatchAsync<GlobalEntryManagerResource, GlobalEntryManagerProperties>;
  delete is ArmResourceDeleteAsync<GlobalEntryManagerResource>;
  listByResourceGroup is ArmResourceListByParent<GlobalEntryManagerResource>;
  listBySubscription is ArmListBySubscription<GlobalEntryManagerResource>;
}

@armResourceOperations
interface EntryProfile {
  get is ArmResourceRead<EntryProfileResource>;
  create is ArmResourceCreateOrUpdateAsync<EntryProfileResource>;
  update is ArmResourcePatchAsync<EntryProfileResource, EntryProfileProperties>;
  delete is ArmResourceDeleteAsync<EntryProfileResource>;
  listByResourceGroup is ArmResourceListByParent<EntryProfileResource>;
  listBySubscription is ArmListBySubscription<EntryProfileResource>;
}

@armResourceOperations
interface EntryProfileRule {
  get is ArmResourceRead<EntryProfileRuleResource>;
  create is ArmResourceCreateOrUpdateAsync<EntryProfileRuleResource>;
  update is ArmResourcePatchAsync<EntryProfileRuleResource, EntryProfileRuleProperties>;
  delete is ArmResourceDeleteAsync<EntryProfileRuleResource>;
  listByResourceGroup is ArmResourceListByParent<EntryProfileRuleResource>;
  listBySubscription is ArmListBySubscription<EntryProfileRuleResource>;
}


@armResourceOperations
interface EntryRegion {
  get is ArmResourceRead<EntryRegionResource>;
  create is ArmResourceCreateOrUpdateAsync<EntryRegionResource>;
  update is ArmResourcePatchAsync<EntryRegionResource, EntryRegionProperties>;
  delete is ArmResourceDeleteAsync<EntryRegionResource>;
  listByResourceGroup is ArmResourceListByParent<EntryRegionResource>;
  listBySubscription is ArmListBySubscription<EntryRegionResource>;
}

@armResourceOperations
interface EntryLink {
  get is ArmResourceRead<EntryLinkResource>;
  create is ArmResourceCreateOrUpdateAsync<EntryLinkResource>;
  update is ArmResourcePatchAsync<EntryLinkResource, EntryLinkProperties>;
  delete is ArmResourceDeleteAsync<EntryLinkResource>;
  listByResourceGroup is ArmResourceListByParent<EntryLinkResource>;
  listBySubscription is ArmListBySubscription<EntryLinkResource>;
}