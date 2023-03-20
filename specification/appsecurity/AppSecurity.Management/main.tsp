import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./ipList/ipList.tsp";
import "./geoList/geoList.tsp";
import "./policy/wafPolicy/customRules.tsp";
import "./policy/wafPolicy/logScrubbing.tsp";
import "./policy/wafPolicy/managedRules.tsp";
import "./policy/wafPolicy/policySettings.tsp";
import "./policy/wafPolicy/wafPolicy.tsp";
import "./policy/policy.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;
using OpenAPI;

@doc("APIs to manage AppSecurity resources")
@armProviderNamespace("Microsoft.AppSecurity")
@service({
  title: "Microsoft.AppSecurity",
})
@versioned(Versions)
namespace Microsoft.AppSecurity;

interface Operations extends Azure.ResourceManager.Operations {}

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_02_06_preview: "2023-02-06-preview",
}
