# Azure alternative-size preflight — 2026-11-05

**Result: no eligible VM SKU in the three permitted regions.** No VM provisioning request was sent in this final preflight. The existing resource group was absent, and this check created no cloud resources.

## Subscription, credit, and quota

- Azure CLI authentication succeeded; subscription state was Enabled, offer AzureForStudents_2018-01-01, and spendingLimit was On.
- The refreshed credit balance summary showed USD 100.00 current and estimated balance, USD 0.00 pending eligible charges. The active credit lot reported USD 100.00 original amount, isEstimatedBalance=false, start 2026-09-22 22:35:26 UTC, expiration 2027-09-22 22:35:26 UTC.
- Regional quota in Chile Central, West US, and Canada Central was 0/4 Standard BS family instances and 0/6 cores.
- Canonical Ubuntu 24.04 image 24.04.202610210 was available without a Marketplace plan in each region.

## Subscription SKU restrictions

The requested az vm list-skus CLI calls did not return within the inspection window. I queried the same Microsoft.Compute SKU endpoint directly with the authenticated Azure CLI session and the location filter. The API returned the following explicit Location restrictions:

| Region | Standard_B1ms | Standard_B2s |
| --- | --- | --- |
| Chile Central | NotAvailableForSubscription, value ChileCentral | NotAvailableForSubscription, value ChileCentral |
| West US | NotAvailableForSubscription, value westus | NotAvailableForSubscription, value westus |
| Canada Central | NotAvailableForSubscription, value CanadaCentral | NotAvailableForSubscription, value CanadaCentral |

Canada Central also returned Zone restrictions with NotAvailableForSubscription for both candidate sizes. The candidate sizes appeared in the regional SKU response, but the subscription-specific restrictions make them ineligible. A separate regional size query listed B1ms (1 vCPU, 2 GiB) and B2s (2 vCPU, 4 GiB) in Canada Central; size presence alone does not override the restriction.

No VM create requests were sent because every size/region combination in the requested strategy was subscription-restricted. This avoids spending on requests Azure has already marked unavailable for this subscription.

## Current retail price estimate

The Azure Retail Prices API returned these Linux consumption rates:

| Size | Chile Central | West US | Canada Central |
| --- | ---: | ---: | ---: |
| Standard_B1ms | USD 0.0291/hour | USD 0.0248/hour | USD 0.0230/hour |
| Standard_B2s | USD 0.0582/hour | USD 0.0496/hour | USD 0.0464/hour |

Conservative hypothetical B2s deployment for one hour: highest compute USD 0.0582; one hour of a 32-GiB Standard SSD E4 OS disk USD 0.0046; two one-hour Standard IPv4 allocations USD 0.010; 1 GB South America internet egress USD 0.181, assuming the free allowance was already used; and 1 million Standard SSD operations USD 0.28. Subtotal USD 0.5338; plus a 25% reserve, USD 0.6673, rounded to **USD 0.67**. This fits the authorized USD 1.00 promotional-credit limit with about USD 0.33 margin, but is not an Azure hard cap or a posted charge.

Disk/IP/transaction rates above were retrieved from Azure retail pricing earlier on 2026-11-05. No discount or free allowance was assumed. No resources were created in this preflight, so it incurred no new deployment charges. Cost reporting can lag usage from earlier attempts.

## Final state

The latest checks returned:

> GROUP_EXISTS=false REMNANTS=0 VMS=0

No Azure resources, VM, managed disk, public IP, NIC, VNet, NSG, or key were created or left by this final preflight. No live page existed to screenshot. No Linux, SSH, Nginx, DNS, firewall, or HTTP test was performed. The earlier OCI evidence remains separate and unchanged.
