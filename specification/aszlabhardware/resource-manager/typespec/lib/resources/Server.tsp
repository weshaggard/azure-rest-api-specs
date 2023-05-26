import "../service.tsp";
import "./Pool.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A physical piece of hardware within a Pool")
@parentResource(Pool)
model Server is ProxyResource<ServerProperties> {
    @doc("The name of the server")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("ServerName")
    @segment("Servers")
    @path
    name: string;
}

@doc("Details of the AszLabHw Server.")
model ServerProperties {
    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Servers extends ProxyResourceOperations<Server> {}
