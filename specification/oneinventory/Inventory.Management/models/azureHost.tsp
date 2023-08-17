import "./common.tsp";

@doc("Azure Host Properties")
model AzureHostProperties {
  @doc("Node Id")
  nodeId: string;

  @doc("Cluster Id")
  @pattern("[/providers/Microsoft.Inventory/physicalClusters/]{1}[a-zA-Z0-9-]+")
  clusterId: string;

  @doc("Provisionsing state")
  provisioningState?: Microsoft.Inventory.ProvisioningState;
}
