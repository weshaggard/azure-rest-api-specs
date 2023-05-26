import "../service.tsp";
import "./Server.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A Collection of Servers")
model Stamp is TrackedResource<StampProperties> {
    @doc("The name of the stamp")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("StampName")
    @segment("Stamps")
    @path
    name: string;
}

@doc("Details of the AszLabHw Stamp.")
model StampProperties {
    @visibility("read", "query", "create", "delete")
    @doc("The servers in the stamp.")
    serverList: Server[];

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Stamps extends TrackedResourceOperations<Stamp, StampProperties> {}
