# linux-cloud-module02

Beginner internship module: Linux, networking, and cloud infrastructure (Day 6-Day 10).

## Execution status — 2026-11-05

**Not completed.** Earlier Standard_B1s provisioning requests were rejected for host capacity in Chile Central, West US, and Canada Central. This final alternative-size preflight found that both Standard_B1ms and Standard_B2s are marked NotAvailableForSubscription in all three permitted regions. No VM provisioning request was sent in this final preflight, and no VM or managed disk exists.

The Azure and OCI records are separate: [evidence/oci-preflight-20261105.md](evidence/oci-preflight-20261105.md) is the historical OCI capacity check; [evidence/azure-capacity-attempt-20261105.md](evidence/azure-capacity-attempt-20261105.md) records the earlier B1s attempts and cleanup; [evidence/azure-alternative-skus-20261105.md](evidence/azure-alternative-skus-20261105.md) records this latest SKU restriction check. None claims successful Linux or web-server execution.

### Provider results

| Provider/location | Result |
| --- | --- |
| OCI, us-ashburn-1 | Historical preflight: Always Free E2.1.Micro allowance was used; A1.Flex host capacity was unavailable in all three availability domains. No OCI resources were created. OCI was not retried. |
| Azure, East US | Resource policy denied the attempted network security group because East US was not an allowed deployment region. East US was not retried. |
| Azure, Chile Central | Earlier B1s request failed host capacity. Current SKU API marks B1ms and B2s NotAvailableForSubscription. |
| Azure, West US | Earlier B1s request failed host capacity. Current SKU API marks B1ms and B2s NotAvailableForSubscription. |
| Azure, Canada Central | Earlier B1s request failed host capacity. Current SKU API marks B1ms and B2s NotAvailableForSubscription. |

The targeted az vm list-skus CLI call did not return. The same Microsoft.Compute SKU API returned the per-region restrictions recorded in the new evidence file. Regional quotas were available, but do not override a subscription restriction.

### Azure eligibility and cost gate

The Azure for Students subscription is Enabled, with spendingLimit=On. A refreshed billing check showed USD 100.00 in the active credit lot, not estimated, expiring 2027-09-22 22:35:26 UTC; pending eligible charges were USD 0.00 at that check. No upgrade was made and the spending limit was not changed. The credit and current charges can still change as billing data is processed.

The regional B-series quota showed 0 of 4 Standard BS family instances and 0 of 6 total cores used in each checked region. Canonical Ubuntu 24.04 was present without a Marketplace plan, but the selected VM sizes were subscription-restricted.

Retail prices returned:

| Size | Chile Central | West US | Canada Central |
| --- | ---: | ---: | ---: |
| Standard_B1ms | USD 0.0291/hour | USD 0.0248/hour | USD 0.0230/hour |
| Standard_B2s | USD 0.0582/hour | USD 0.0496/hour | USD 0.0464/hour |

A conservative hypothetical one-hour B2s deployment estimate is **about USD 0.67**, including a 25% reserve and no assumed free-usage allowances: highest B2s rate USD 0.0582, one hour of a 32-GiB Standard SSD E4 OS disk at USD 0.0046, two one-hour Standard IPv4 allocations at USD 0.010, 1 GB of South America internet egress at USD 0.181, and 1 million disk operations at USD 0.28. The subtotal is USD 0.5338; with 25% reserve it is USD 0.6673. This estimate is below the authorized USD 1.00 promotional-credit limit but is not an Azure hard cap or an invoice.

No resources were created in this final SKU preflight. The earlier B1s check created temporary network resources, which were deleted; their conservative estimated IPv4 usage was at most USD 0.015. Billing can lag resource activity, so no final zero-cost claim is made. See [Azure spending limits](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/spending-limit), [Azure for Students offer](https://azure.microsoft.com/en-us/pricing/offers/ms-azr-0170p), [Linux VM pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/), [Retail Prices API](https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices), [managed disks](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types), [bandwidth pricing](https://azure.microsoft.com/en-us/pricing/details/bandwidth/), and [Cost Management data timing](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/understand-cost-mgt-data).

### Objective status

| Objective | Status |
| --- | --- |
| Create an eligible Ubuntu VM and secure network access | Not completed: B1s host capacity failed previously; B1ms and B2s are currently subscription-restricted in all three permitted regions. |
| Demonstrate Linux CLI, users, groups, permissions, processes, services, and SSH | Not executed: no VM was available. |
| Install Nginx and verify local/external HTTP 200, DNS, and firewall | Not executed: no VM or endpoint existed. |

No VM, SSH, Linux, DNS, firewall, or HTTP tests were performed in this final preflight. No screenshot of a live Module 02 page exists. The existing Nginx and verification scripts remain procedures, not execution evidence.

### Cleanup

The resource group internship-m02-demo is absent. The latest subscription-wide check returned zero resources with the prior run tag or expected names, zero matching VMs, and no new resources from this final preflight. The temporary SSH key from the earlier attempt was removed. Existing OCI resources and VIRTUPRO/DICSAR infrastructure were not modified.

See [CLEANUP.md](CLEANUP.md) for the cleanup record and safe procedure.

## Repository files

- scripts/setup-nginx.sh installs Nginx and UFW on Ubuntu, restricts SSH to the supplied client CIDR, and publishes the module page. It was not run on a VM in this execution.
- scripts/verify.sh contains the Linux, service, DNS, network, and HTTP checks. It was not run because no VM was created.
- evidence/ contains sanitized real preflight, capacity, restriction, and cleanup outputs. It contains no fabricated VM logs or screenshots.
