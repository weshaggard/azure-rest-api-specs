import "../service.tsp";
import "./Stamp.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A configured instance of a Stamp that belongs to some team/individual to run jobs/tests")
model EnvironmentReservation
    is TrackedResource<EnvironmentReservationProperties> {
    @doc("The name of the environment")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("EnvironmentName")
    @segment("Environments")
    @path
    name: string;
}

@doc("Details of the AszLabHw Environment.")
model EnvironmentReservationProperties {
    @visibility("read", "query", "create", "delete")
    @doc("The stamp comprising the environment.")
    stamp: Stamp;

    @visibility("read", "query", "create", "update", "delete")
    @doc("The owner of the environment.")
    owner: string;

    @visibility("read", "query", "create")
    @doc("The expiry date for the environment.")
    expiryDate: object;

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;
}

@armResourceOperations
interface EnvironmentReservations
    extends TrackedResourceOperations<
            EnvironmentReservation,
            EnvironmentReservationProperties
        > {}
