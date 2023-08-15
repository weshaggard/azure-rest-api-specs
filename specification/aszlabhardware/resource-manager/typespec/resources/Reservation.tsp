import "../main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A configured instance of a Stamp that belongs to some team/individual to run jobs/tests")
model Reservation is TrackedResource<ReservationProperties> {
  @doc("The name of the Reservation")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ReservationName")
  @segment("Reservations")
  @path
  name: string;
}

@doc("e.g.: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Private.AszLabHardware/Servers/{ServerName}'.")
scalar ServerId
  extends ResourceIdentifier<[
    {
      type: "Private.AszLabHardware/Servers",
    }
  ]>;

@doc("Details of the AszLabHw Reservation.")
model ReservationProperties {
  @visibility("read", "query", "create")
  @doc("The list of server IDs that this reservation reserves")
  servers: ServerId[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Reservations
  extends TrackedResourceOperations<Reservation, ReservationProperties> {}
