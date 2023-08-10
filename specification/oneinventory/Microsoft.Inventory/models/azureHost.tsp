import "./common.tsp";

@doc("Azure Host Properties")
model AzureHostProperties {
    @doc("Node Id")
    nodeId: string;

    @doc("Cluster Id")
    clusterId: string;

    @doc("Provisionsing state")
    provisioningState?: Microsoft.Inventory.ProvisioningState;
}
