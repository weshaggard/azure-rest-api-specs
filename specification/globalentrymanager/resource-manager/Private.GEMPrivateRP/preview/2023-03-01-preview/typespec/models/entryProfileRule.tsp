import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Protocol for the traffic rule")
enum IpProtocol {
  @doc("Transmission Control Protocol")
  TCP,
  @doc("User Datagram Protocol")
  UDP,
  @doc("Internet Control Message Protocol")
  ICMP,
  @doc("Any protocol")
  Any
}

@doc("Global Entry Profile Rule Properties.")
model EntryProfileRuleProperties extends BaseResourceProperties {
  @doc("The source addresses.")
  @visibility("create", "read", "update")
  sourceAddresses: IpRule[];
  
  @doc("The port that the traffic enters on at the edge of the Global Entry Manager.")
  @visibility("create", "read", "update")
  destinationPorts: string[];

  @doc("The protocol of the source.")
  @visibility("create", "read", "update")
  ipProtocols: IpProtocol[];

  @doc("The address in the exit virtual network that the Global Entry Manager is forwarding traffic to.")
  @visibility("create", "read", "update")
  translatedAddress: IpAddress;
  
  @doc("The port of the address in the exit virtual network that the Global Entry Manager is forwarding traffic to.")
  @visibility("create", "read", "update")
  translatedPort: string;
}