# VideoIndexer Resource Provider

## Purpose
### Problem statement 

Video Indexer is managed as stand-alone product outside of Azure. To use Video Indexer today:
  * Customers create a trial Video Indexer account through the Video Indexer portal or through API     portal (managed by APIM). 
  * Customers create a paid Video Indexer account through the Video Indexer portal. The account is connected to their Media Services account and then they create an APIM subscription to access it through APIs. 
These is a complicated flow and is difficult for customers and partners to manage. 

In addition, Video Indexer uses AAD application IDs and secrets to connect to customers’ Azure resources such as Custom Vision, Media Services, Key Vault, and more are planned to be introduced. This method of authentication is error prone, requires ongoing maintenance and not a security best practice. 

Finally, for Video Indexer to meet Azure enterprise promises it must become an Azure resource as a pre-condition  

### Benefit and Impact  

Managing Video Indexer in the Azure portal using ARM will allow customers and partners to manage their Video Indexer account same as they manage all their Azure resources and will create a better experience for them. In addition, customers and partners will be able to use ARM templates and CLIs to create and manage a VI account.  

Customers will also gain a more secure solution - Video Indexer will be able to use a managed identity to connect to other Azure resources in the future, which is the safe and recommended way to work with Azure resources. Managed identities eliminate the need for VI to store customer secrets and eliminate the customer’s need for maintaining and rotating these secrets. In addition, managed identities require less permissions from the customer and allow them to create a Video Indexer account more easily. 

In addition having Video Indexer in ARM will enable customers to create private links to secure their calls to Video Indexer. 

Being a resource in Azure will also allow Video Indexer to create more integrations required as part of Fulcrum - in the Azure Support Portal (the customer facing portal), and the Azure Support Center (the CSS facing portal). As a resource in Azure, it will also be visible in the Azure Resource Explorer- which is also used by CSS when working on customer cases. 

### Why now?  

To meet enterprise promises Video Indexer is required to have secured integrations between the resources, which can only be achieved by being a resource in Azure and managed by ARM. 

Private links require VI to be an ARM resource, CMK requires integration with the customer’s Key Vault and the most secure manner is managed identities. In addition, integrations with Custom Vision and Media Services would become more trivial and less error prone with managed identities. Lastly, Face API resource that is CMK enabled do not plan to support authentication means other than MI. 

### Requirements 

The goal is to move the Video Indexer’s account management and RBAC to Azure portal and ARM API with its own resource provider. This will only be relevant for paid accounts and not for trial account since trial users don’t necessarily have Azure subscriptions. The process of managing users in trial accounts won't change and wont be part of ARM. 

Users will be able to easily create, manage and delete a Video Indexer account through the Azure portal \ using an ARM template \ using CLI. Account management will not be available via the VI portal anymore.  

## Type Model
Resource provider namespace: Microsoft.VideoIndexer
Resource type:
* accounts - <b><u>type model is still under develop.</u></b>
             The resource type properties are: 
             
            "accountId": {
              "description": "The account's data-plane ID",
              "type": "string",
              "readOnly": true
            },
            "accountName": {
              "description": "The account's name",
              "type": "boolean",
              "readOnly": false
            },
            "amsResourceGroup": {
              "description": "The Ams resource group",
              "type": "string",
              "readOnly": false
            },
            "amsResource": {
              "description": "The Ams resource",
              "type": "string",
              "readOnly": false
            }
            
* accounts/accessToken - <b><u>type model is still under develop.</u></b> 
                        Motivation: once user will provide VI access token, he will be able use all VI’s data plain APIs in APIM. In order to acheive this he will need to get access token via ARM. 
