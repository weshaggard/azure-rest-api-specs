@doc("Destination Rule Properties.")
model DestinationRule {
  @doc("Destination Type.")
  destinationType?: string;

  @doc("Destination must follow the format for FQDNs if it is selected as the destination type (no IP/CIDR or full web URLs).")
  destination?: string;

  @doc("Port. Can include multiple ports separated by commas or a range indicated by a hyphen.")
  port?: string;

  @doc("Protocol. Options specified by Endpoint Protocol Enum.")
  protocol?: EnclaveEndpointProtocol;
}