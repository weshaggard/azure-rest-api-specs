import "../service.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("Pools are logical groupings of servers that have similar use cases")
model Pool is TrackedResource<PoolProperties> {
    @doc("The name of the Pool")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("PoolName")
    @segment("Pools")
    @path
    name: string;
}

@doc("Details of the AszLabHw Pool.")
model PoolProperties {
    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Pools extends TrackedResourceOperations<Pool, PoolProperties> {}
