import "./index.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("CognitiveSearch Indexer Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.Search;

@parentResource(Index)

@doc("An indexer resource is a child tracked resource of index")
model Indexer is TrackedResource<IndexerProperties>{
    @path
    @key("indexerName")
    @segment("indexers")
    @visibility("read")
    @doc("The name of the indexer resource.")
    name: string;
}

@armResourceOperations
interface IndexerOperations{
    createOrUpdate is ArmResourceCreateOrUpdateAsync<Indexer>;
    update is ArmResourcePatchAsync<Indexer, IndexerProperties>;
    delete is ArmResourceDeleteAsync<Indexer>;
}

  @doc("The properties of the indexer.")
  model IndexerProperties {
    @doc("The description of the indexer resource.")
    description?: string;

    @visibility("read")
    @doc("The current provisioning state of the indexer.")
    provisioningState?: ProvisioningState;

    @doc("The failure policy.")
    failurePolicy: FailurePolicy;

    @doc("Connection and container information for Datasource")
    datasource: Datasource;
  }

  @doc("datasource object")
  model Datasource {
    @doc("Data source Connection defintion")
    connection: Connection;
    
    @doc("other datasource Properties")
    properties: DatasourceProperties;
  }

  @discriminator("authenticationType")
  @doc("Parent connection object")
  model Connection {}

  @doc("Credentials definition")
  model Credentials extends Connection {
    @doc("Connection type")
    authenticationType: "Credentials";
  
    @doc("Connection string")
    connectionString: string;
  }

  @doc("System assigned identity")
  model SystemAssignedIdentity extends Connection {
    @doc("Connection type")
    authenticationType: "SystemAssignedIdentity";
  
    @doc("Resource id of the storage account/cosmos db account/ Azure sql account")
    datasourceResourceId: string;
  }
  
  @doc("User assigned identity ")
  model UserAssignedIdentity extends Connection {
    @doc("Connection type")
    authenticationType: "UserAssignedIdentity";
  
    @doc("Resource id of the storage account/cosmos db account/ Azure sql account")
    datasourceResourceId: string;

    @doc("User assigned identity resource id")
    userAssignedIdentityResourceId: string;
  }

  @discriminator("type")
  @doc("Datasource properties types")
  model DatasourceProperties {}

  @doc("CosmosDB_NoSql Datasource")
  model CosmosDB extends DatasourceProperties {
    @doc("CosmosDB datasource type")
    type: CosmosDBTypes;

    @doc("CosmosDB Database name")
    collectionName: string;

    @doc("Query information")
    query: string;
  }

  @doc("AzureSql Datasource")
  model AzureSql extends DatasourceProperties {
    @doc("AzureSql datasource type")
    type: "AzureSql";

    @doc("AzureSql Database name")
    tableOrViewName: string;
  }

  @doc("AzureStorage Blob and Table Datasource")
  model AzureStorage extends DatasourceProperties {
    @doc("AzureBlob datasource type")
    type: AzureStorageTypes;

    @doc("AzureBlob container name")
    containerName: string;
    
    @doc("Query information")
    query: string;
  }

@doc("Failure policy parent")
model FailurePolicy {
  @doc("Failure policy type")
  type: FailurePolicyType;
}

@doc("Supported DataSource types")
enum DataSourceType {
  AzureSql,
  CosmosDB,
  AzureBlob,
  AzureTable,
}

@doc("Supported CosmosDB Subtype values")
union CosmosDBTypes {
  NoSql: "CosmosDB/NoSql", 
  MongoDB: "CosmosDB/MongoDB",
  Cassendra: "CosmosDB/Cassendra",
  Gremlin: "CosmosDB/Gremlin",
}

@doc("Supported Azure Storage Subtype values")
union AzureStorageTypes {
  Blob: "AzureStorage/Blob", 
  Table: "AzureStorage/Table",
}

@doc("Supported Failure policy")
enum FailurePolicyType {
  @doc("Indexer will stop after the first failure.")
  FailOnFirstFailure,
  @doc("Indexer will not stop for the specified number of failures")
  TolerateFailures
}

