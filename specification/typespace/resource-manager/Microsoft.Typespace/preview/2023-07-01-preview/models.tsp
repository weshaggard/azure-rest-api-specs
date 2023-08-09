import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.TypeSpace;

@tenantResource
model NameSpace is ProxyResource<NameSpaceProperties> {
  @doc("The namespace")
  @pattern("^[a-zA-Z0-9-.]{3,50}$")
  @key("nameSpaceName")
  @segment("nameSpaces")
  @path
  @visibility("read")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the namespace")
model NameSpaceProperties {
  @doc("The list of types under the namespace")
  types: string[];
}

@tenantResource
@parentResource(NameSpace)
model Type is ProxyResource<TypeProperties> {
  @doc("The name of the type")
  @pattern("^[a-zA-Z0-9-]{3,50}$")
  @key("typeName")
  @segment("types")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the type")
model TypeProperties {
  @doc("The resource type namespace")
  nameSpace: string;
  @doc("The list of API versions for the type")
  versions: string[];
}

@tenantResource
@parentResource(Type)
model Version is ProxyResource<VersionProperties> {
  @doc("The version of the type")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("version")
  @segment("versions")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the version")
model VersionProperties {
  @doc("The resource namespace")
  nameSpace: string;
  @doc("The resource type")
  resourceType: string;
  @doc("The list of operations under the API version")
  operations: string[];
}

@tenantResource
@parentResource(Type)
model Annotation is ProxyResource<AnnotationProperties> {
  @doc("The annotations of the type")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("annotationName")
  @segment("annotations")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the annotations")
model AnnotationProperties {
  @doc("The resource namespace")
  nameSpace: string;
  @doc("The resource type")
  resourceType: string;
  @doc("map of path to annotation")
  values: string;
}

@tenantResource
@parentResource(Version)
model Operation is ProxyResource<OperationProperties> {
  @doc("The name of the operation")
  @pattern("^[a-zA-Z0-9-]{3,50}$")
  @key("operation")
  @segment("operations")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the resource operation")
model OperationProperties {
  @doc("The resource namespace")
  nameSpace: string;
  @doc("The resource type")
  resourceType: string;
  @doc("The API Version")
  version: string;
  @doc("The possible response codes")
  responseCode: string;
}