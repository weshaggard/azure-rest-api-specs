import "../main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

@doc("The status of the server")
enum Status {
  @doc("The server is rented out")
  Reserved,

  @doc("The server is available to be rented out")
  Available,

  @doc("The server is rented out and will undergo maintenance on check-in")
  PendingMaintenance,

  @doc("The server is undergoing maintenance")
  InMaintenance,

  @doc("The server is completed with maintenance and will be available soon")
  PendingAvailable,
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A physical computer which can be reserved for use by a user")
model Server is TrackedResource<ServerProperties> {
  @doc("The name of the server")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ServerName")
  @segment("Servers")
  @path
  name: string;
}

@doc("Details of the AszLabHw Server.")
model ServerProperties {
  @visibility("read", "query")
  @doc("The status of the server")
  status: Status;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Servers extends TrackedResourceOperations<Server, ServerProperties> {}
