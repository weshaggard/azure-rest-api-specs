import "./common.tsp";

@doc("The Subscription internal properties")
model SubscriptionInternalProperties {
  @doc("Billing properties.")
  billingProperties?: BillingProperties;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Subscription diplay name")
  displayName?: string;

  @doc("Entitilement start date")
  entitlementStartDate?: string;

  @doc("Offer Category")
  offerCategory?: string;

  @doc("offer Type")
  offerType?: string;

  @doc("Promotions")
  promotions?: PromotionsList;

  @doc("Current state of subscription")
  state?: State;

  @doc("Subscription policies")
  subscriptionPolicies?: SubscriptionPolicies;

  @doc("internal subscription policies")
  internalSubscriptionPolicies?: InternalSubscriptionPolicies;

  @doc("Tenant Id")
  tenantId: string;

  @doc("Changed Time")
  changedTime?: string;

  @doc("Created Time")
  createdTime?: string;

  @doc("Provisionsing state")
  provisioningState?: ProvisioningState;
}

@doc("List of promotions")
model PromotionsList  {
   @doc("Promtion")
   value: PromotionData[];
}

@doc("Promtion")
model PromotionData {

  @doc("promotion category free vs pay-as-you-go")
  category: string;

  @doc("promotion end date time")
  endDateTime: string
}


@doc("Subscription state")
enum State { 
  Registered,
  Unregistered,
  Warned,
  Suspended,
  Deleted
}

@doc("The Subscription billing properties")
model BillingProperties {
    @doc("Commerce object identifying additional state information associated with the subscription.")
    additionalStateInformation: AdditionalStateInformation;

    @doc("Billing account of the customer that holds customer payment instrument, address etc. The subscription is always linked to a billing account.")
    billingAccount: BillingAccount;

    @doc("Indicates the commerce stack that this account is on - modern or legacy")
    billingType: BillingType;
    
    @doc("Indicates the sales motion that this subscription type belongs to. This can be changed if a subscription moves from one channel type to another (e.g., CustomerLed to PartnerLed)")
    channelType: ChannelType;
    
    @doc("Differentiates how customer is paying for the subscription. This can change if customer changes from free to paid, etc.")
    paymentType: PaymentType;
    
    @doc("Customer segment")
    tier: Tier;
    
    @doc("Indicates the importance of this subscription. DevTest subscriptions get lower SLA compared to Production ones. This property can be changed later if needed as well.")
    workloadType: WorkloadType
}

@doc("Commerce object identifying additional state information associated with the subscription.")
model AdditionalStateInformation {
    @doc("Indicates whether the Non data retention resources can be released. This is a high confidence signal that would be set to true when the subscription is already in disabled state. To learn about Azure Data Retention policy after subscription has been disabled see")
    releaseNonDataRetentionResource?: boolean;

    @doc("Indicates whether the new resource creation should be blocked. Existing resources functionality should not be impacted. This signal should be looked at when subscription state is Active. The service should be able to recover if the flag is reset to false.")
    blockNewResourceCreation?: boolean
}

@doc("Billing account of the customer that holds customer payment instrument, address etc. The subscription is always linked to a billing account.")
model BillingAccount {
    @doc("Unique Id identifying the commerce object for the billing account.")
    id: string
}

@doc("Subscription state image type")
enum BillingType {    
  Legacy,
  Modern
}

@doc("Subscription state image type")
enum ChannelType {    
  None, 
  Internal,
  FieldLed,
  CustomerLed,
  PartnerLed
}

@doc("Subscription state image type")
enum PaymentType {    
  None,
  Paid,
  Free,
  Entitlement,
  SponsoredPlus,
  Sponsored,
  Benefit
}

@doc("Subscription state image type")
enum Tier {    
  Unknown,
  Standard,
  Premium,
  Priority
}

@doc("Subscription state image type")
enum WorkloadType {    
  None,
  DevTest,
  Production
}

@doc("CostCategory for internal subscription")
enum CostCategory {    
  None,
  FR,
  FG,
  FS,
  FX,
  FB
}

@doc("The Subscription policies")
model SubscriptionPolicies {
    @doc("The placement requirement for the subscription based on its country of origin / offer type / offer category / etc. This is used in geo-fencing of certain regions or regulatory boundaries (e.g. Australia ring-fencing).")
    locationPlacementId: string;

    @doc("The quota requirement for the subscription based on the offer type / category (e.g. free vs. pay-as-you-go). This can be used to inform quota information for the subscription (e.g. max # of resource groups or max # of virtual machines.")
    quotaId: string;

    @doc("Indicates whether subscription has spending limit.")
    spendingLimit: string
}

@doc("The Internal Subscription policies")
model InternalSubscriptionPolicies {
    @doc("Cost categorizations used for internal subscriptions.")
    costCategory: CostCategory;

    @doc("Environment for the internal subscription.")
    environment: string;

    @doc("PCCode for the internal subscription.")
    pcCode: string
}