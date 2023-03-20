namespace Microsoft.AppSecurity;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

/* *********************************
 * GeoList resource definitions
 ********************************* */
@doc("The GeoList properties")
model GeoListProperties {
  @doc("The status of the last operation")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("List of countries or regions")
  geoList: string[]; // TODO - should we verify with the pattern decorator?

  @doc("The list of back references to policies that use this Geo list")
  @visibility("read")
  policies?: string[];
}

@doc("GeoList resource")
model GeoList is TrackedResource<GeoListProperties> {
  @doc("The name of the GeoList")
  @key("listName")
  @segment("geoLists")
  @path
  name: string;
}

@armResourceOperations(GeoList)
interface GeoLists
  extends TrackedResourceOperations<GeoList, GeoListProperties> {}
