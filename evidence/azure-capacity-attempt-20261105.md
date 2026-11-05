# Azure capacity attempt and cleanup evidence — 2026-11-05

**Status: blocked before VM provisioning.** This is a sanitized record of live Azure CLI/API responses and resource inventories. It is not evidence of a successful VM, SSH, Linux, Nginx, DNS, firewall, or HTTP test.

## Eligibility and cost gates

- Azure CLI authentication succeeded. Immediately before VM requests, subscription state was Enabled, offer AzureForStudents_2018-01-01, and spendingLimit was On. The spending limit was never removed and no upgrade was made.
- The predeployment billing-profile snapshot showed USD 100.00 remaining promotional credit, not estimated, expiring 2027-09-22 22:35:26 UTC. This is a predeployment snapshot; final balance after delayed usage reporting was not asserted.
- Region policy allowed Chile Central, West US, and Canada Central. B1s quota showed 0 used of 4 Standard BS family instances and 0 used of 6 total cores in the checked candidate region.
- Canonical Ubuntu 24.04 image version 24.04.202610210 was returned with a null plan in each candidate region. The image was not deployed.
- The live Retail Prices API returned Standard_B1s Linux rates of USD 0.0124/hour in West US and USD 0.0116/hour in Canada Central. A prior regional price lookup returned USD 3.36/month for Standard SSD E4 (32 GiB), USD 0.005/hour for Standard static IPv4, and USD 0.0028 per 10,000 billable disk operations. The West US bandwidth price lookup returned USD 0.087/GB after the first 100 GB/month. No free allowance was assumed in the full-demo estimate.
- Full intended-demo planning envelope: one hour B1s at USD 0.0124, one hour disk at USD 0.0046, three one-hour IPv4 allocations at USD 0.015, up to 1 GB egress at USD 0.087, and 1 million disk operations at USD 0.28. Subtotal USD 0.399; plus a 25% reserve, USD 0.499, rounded to **USD 0.50**. This estimate is below the authorized USD 1.00 promotional-credit limit, but is not a billing guarantee or posted charge.
- The failed run created no VM, managed OS disk, or workload traffic. The conservative estimate for the actual temporary network resources is at most USD 0.015 for three IPv4 allocations budgeted at one full hour each. No post-run finalized charge was queried; Azure may report usage later, so no posted amount is claimed.

Pricing references: [Azure for Students](https://azure.microsoft.com/en-us/pricing/offers/ms-azr-0170p), [Linux VM pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/), [Retail Prices API](https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices), [managed disks](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types), [bandwidth](https://azure.microsoft.com/en-us/pricing/details/bandwidth/), and [Cost Management data timing](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/understand-cost-mgt-data).

## VM capacity responses

Azure rejected each VM request during preflight validation:

- Chile Central: SkuNotAvailable — Standard_B1s was not currently available in location ChileCentral.
- West US: SkuNotAvailable — Standard_B1s was not currently available in location westus.
- Canada Central: SkuNotAvailable — Standard_B1s was not currently available in location CanadaCentral.

The Azure CLI also emitted an internal error reading the response body (The content for this response was already consumed). The underlying Azure response contained the explicit SkuNotAvailable capacity message. No VM or managed disk appeared after any failed request. No further region was attempted.

An earlier East US NSG request was denied by the subscription's allowed-region policy. No East US network footprint remained.

## Real network and cleanup outputs

For the network-only footprint before each VM attempt, the live validation returned:

> SSH_RULE_RESTRICTED_TO_CURRENT_IPV4_32=True HTTP_80_PUBLIC=True STANDARD_IPV4_PRESENT=True

The client IP itself is intentionally omitted. The four temporary resource names were internship-m02-vnet, internship-m02-nsg, internship-m02-pip, and internship-m02-nic. The inventory was captured before each deletion and contained only those network resources; each regional footprint was removed by deleting the exact tagged resource group before moving to another region.

Final subscription-wide verification returned:

> GROUP_EXISTS=false
>
> RUN_TAG_OR_EXPECTED_NAME_COUNT=0
>
> VM_NAMED_OR_TAGGED_DISK_COUNT=0
>
> DISK_RESULTS=

The final pre-delete inventory also returned VM_COUNT=0 and DISK_COUNT=0. No VM, managed disk, public IP, NIC, VNet, NSG, or resource group belonging to this run remains.

No successful live webpage existed to screenshot. No screenshot of a Module 02 page, SSH session, or HTTP 200 is included because those actions never occurred. The OCI preflight record remains unchanged at evidence/oci-preflight-20261105.md.
