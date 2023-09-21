import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./index.tsp";
import "./indexer.tsp";

using Autorest;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
    title: "IndexManagementClient",
    version: "2023-05-01-preview",
})
@doc("CognitiveSearch Resource Provider management API.")
@useDependency(Azure.Core.Versions.v1_0_Preview_1)
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.Search;
