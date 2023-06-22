  import "@typespec/http";
  import "@typespec/rest";
  import "@typespec/versioning";
  import "@azure-tools/typespec-providerhub";
  import "@azure-tools/typespec-azure-core";
  import "@azure-tools/typespec-azure-resource-manager";
  import "@typespec/openapi";
  
  using TypeSpec.Http;
  using TypeSpec.Rest;
  using TypeSpec.Versioning;
  using Azure.Core;
  using Azure.ResourceManager;
  using OpenAPI;
  
  @armProviderNamespace
  @service({
    title: "Microsoft.AwsConnector",
    version: "2023-12-01-preview",
  })
  @doc("Microsoft.AwsConnector Resource Provider management API.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  namespace Microsoft.AwsConnector;
  
  //---------------------------------------------- S3Buckets ----------------------------------------------
  @doc("A Microsoft.AwsConnector resource")
  model S3Bucket is TrackedResource<S3BucketProperties> {
    @doc("Name of S3Bucket")
    @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
    @key("name")
    @path
    @segment("s3Buckets")
    name: string;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
  @doc("Definition of AwsCommon")
  model AwsCommonProperties {
    @doc("Gets and sets the property publicCloudConnectorsResourceId. ")
    publicCloudConnectorsResourceId?: string;

    @doc("Gets and sets the property awsAccountId. ")
    awsAccountId?: string;

    @doc("Gets and sets the property awsResourceName. ")
    awsResourceName?: string;

    @doc("Gets and sets the property awsSdkVersion. ")
    awsSdkVersion?: string;

    @doc("Gets and sets the property awsRegion. ")
    awsRegion?: string;

    @visibility("read")
    @doc("Gets and sets the property provisioningState. The status of the last operation.")
    provisioningState?: ProvisioningState;

  }

  @doc("Definition of S3Bucket")
  model S3BucketProperties extends AwsCommonProperties{
    @doc("Gets and sets the property awsProperties. ")
    awsProperties?: AwsS3BucketProperties;

  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
  @doc("Definition of awsS3Bucket")
  model AwsS3BucketProperties {
    @doc("Gets and sets the property creationDate. <p>Date the bucket was created. This date can change when making changes to your bucket, such as editing its bucket policy.</p>")
    creationDate?: utcDateTime;

    @doc("Gets and sets the property name. <p>The name of the bucket.</p>")
    name?: string;

  }

  @armResourceOperations
  interface S3Buckets
  {
    get is ArmResourceRead<S3Bucket>;
    createOrUpdate is ArmResourceCreateOrUpdateAsync<S3Bucket>;
    update is ArmTagsPatchAsync<S3Bucket, S3BucketProperties>;
    delete is ArmResourceDeleteAsync<S3Bucket>;
    listByResourceGroup is ArmResourceListByParent<S3Bucket>;
    listBySubscription is ArmListBySubscription<S3Bucket>;
  }

  @doc("The provisioning state of a resource.")
  @lroStatus
  enum ProvisioningState {
    ...ResourceProvisioningState,

    @doc("The resource is being provisioned")
    Provisioning,

    @doc("The resource is updating")
    Updating,

    @doc("The resource is being deleted")
    Deleting,

    @doc("The resource create request has been accepted")
    Accepted,
  }
