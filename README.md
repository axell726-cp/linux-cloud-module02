# linux-cloud-module02

Beginner internship module: Linux, networking, and cloud infrastructure (Day 6-Day 10).

## Latest execution status — rechecked 2026-11-10

**Not completed.** The Azure B1ms/B2s restrictions remain documented. On 2026-11-10, AWS authentication and a Paid plan were verified; promotional credits cover EC2, VPC, and data transfer, with USD 53.15 estimated remaining. I did not launch a VM because the account's tax location could not be confirmed and AWS promotional credits exclude transaction taxes, so zero out-of-pocket cost could not be guaranteed. No AWS resources were created. The Linux, SSH, Nginx, DNS, firewall, and HTTP objectives remain unexecuted.

The Azure and OCI records are separate: [evidence/oci-preflight-20261105.md](evidence/oci-preflight-20261105.md) is the historical OCI capacity check; [evidence/azure-capacity-attempt-20261105.md](evidence/azure-capacity-attempt-20261105.md) records earlier B1s attempts and cleanup; [evidence/azure-alternative-skus-20261105.md](evidence/azure-alternative-skus-20261105.md) records the November 5 SKU check; [evidence/azure-sku-recheck-20261109.md](evidence/azure-sku-recheck-20261109.md) contains the November 9 CLI outputs; [evidence/aws-preflight-20261110.md](evidence/aws-preflight-20261110.md) records the AWS credit, price, and tax gate. None claims successful Linux or web-server execution.

### Provider results

| Provider/location | Result |
| --- | --- |
| OCI, us-ashburn-1 | Historical preflight: Always Free E2.1.Micro allowance was used; A1.Flex host capacity was unavailable in all three availability domains. No OCI resources were created. OCI was not retried. |
| Azure, East US | Resource policy denied the attempted network security group because East US was not an allowed deployment region. East US was not retried. |
| Azure, Chile Central | Earlier B1s request failed host capacity. The 2026-11-09 SKU API recheck marks B1ms and B2s NotAvailableForSubscription. |
| Azure, West US | Earlier B1s request failed host capacity. The 2026-11-09 SKU API recheck marks B1ms and B2s NotAvailableForSubscription. |
| Azure, Canada Central | Earlier B1s request failed host capacity. The 2026-11-09 SKU API recheck marks B1ms and B2s NotAvailableForSubscription. |
| AWS, us-east-1 | Preflight only: the active credit covered EC2, VPC, and data transfer, but tax treatment could not be verified; no resources were created. |

The November 5 az vm list-skus CLI call did not return. On November 9, the authenticated Microsoft.Compute SKU API query returned the restrictions recorded in the new evidence file. Regional quotas were available, but do not override a subscription restriction.

### Azure eligibility and cost gate

The Azure for Students subscription was confirmed Enabled with spendingLimit=On on 2026-11-09. The latest verified balance snapshot remains 2026-11-05: USD 100.00 in the active credit lot, not estimated, expiring 2027-09-22 22:35:26 UTC; pending eligible charges were USD 0.00 at that time. The balance was not refreshed on November 9 because both VM sizes failed the subscription SKU gate before any deployment. No upgrade was made and the spending limit was not changed.

The 2026-11-09 regional B-series quota showed 0 of 4 Standard BS family vCPUs and 0 of 6 total regional vCPUs used in each checked region. Canonical Ubuntu 24.04 was present without a Marketplace plan, but the selected VM sizes were subscription-restricted.

Retail prices recorded on 2026-11-05 (not refreshed on November 9):

| Size | Chile Central | West US | Canada Central |
| --- | ---: | ---: | ---: |
| Standard_B1ms | USD 0.0291/hour | USD 0.0248/hour | USD 0.0230/hour |
| Standard_B2s | USD 0.0582/hour | USD 0.0496/hour | USD 0.0464/hour |

The 2026-11-05 conservative hypothetical one-hour B2s deployment estimate was **about USD 0.67**, including a 25% reserve and no assumed free-usage allowances: highest B2s rate USD 0.0582, one hour of a 32-GiB Standard SSD E4 OS disk at USD 0.0046, two one-hour Standard IPv4 allocations at USD 0.010, 1 GB of South America internet egress at USD 0.181, and 1 million disk operations at USD 0.28. The subtotal is USD 0.5338; with 25% reserve it is USD 0.6673. This estimate is below the authorized USD 1.00 promotional-credit limit but is not an Azure hard cap or an invoice.

No resources were created in the 2026-11-09 SKU recheck. The earlier B1s check created temporary network resources, which were deleted; their conservative estimated IPv4 usage was at most USD 0.015. Billing can lag resource activity, so no final zero-cost claim is made. See [Azure spending limits](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/spending-limit), [Azure for Students offer](https://azure.microsoft.com/en-us/pricing/offers/ms-azr-0170p), [Linux VM pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/), [Retail Prices API](https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices), [managed disks](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types), [bandwidth pricing](https://azure.microsoft.com/en-us/pricing/details/bandwidth/), and [Cost Management data timing](https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/understand-cost-mgt-data).

### AWS preflight and cost gate — 2026-11-10

The authenticated AWS Free Tier API reported a PAID, ACTIVE plan with USD 53.15 estimated remaining credits. Billing GetCredits reported USD 65.76 remaining as of the latest completed billing and USD 53.15 estimated for the current cycle. Active promotions included Amazon Elastic Compute Cloud, Amazon Virtual Private Cloud, and AWS Data Transfer. The credits expire 2027-10-03. The account had a 16-instance On-Demand Standard quota, t3.micro was offered in us-east-1, and there were no existing EC2 instances in that region. An existing default VPC had public subnets and an active route to an Internet Gateway; it was inspected only and not modified.

The AWS Price List API returned USD 0.0104 per hour for Linux t3.micro and USD 0.08 per GB-month for gp3. AWS VPC pricing lists public IPv4 at USD 0.005 per hour. A conservative 1-hour estimate for t3.micro, an 8-GiB gp3 root disk, one public IPv4, and 1 GB internet egress (USD 0.09/GB, assuming the free allowance is already used) was USD 0.106277 before tax. With a 100% reserve and an illustrative 18% tax scenario applied to the reserved amount, the total is USD 0.250813. This is an estimate, not a posted charge or hard cap.

No verified tax registration was returned for the account, the installed CLI could not retrieve the primary contact country, and the AWS Billing console required a separate sign-in. Cost Explorer showed zero tax records for October and November 1–9, which does not establish that future usage is tax-exempt. AWS promotional credits do not offset transaction-based taxes. If the account is located in Peru and is a non-business customer, AWS states that 18% VAT applies. The tax status therefore remained unverified and deployment stopped before any resource creation. See [AWS promotional credit terms](https://aws.amazon.com/awscredits/), [AWS Peru tax guidance](https://aws.amazon.com/tax-help/peru/), [EC2 pricing](https://aws.amazon.com/ec2/pricing/on-demand/), [EBS pricing](https://aws.amazon.com/ebs/pricing/), and [VPC pricing](https://aws.amazon.com/vpc/pricing/).

### Objective status

| Objective | Status |
| --- | --- |
| Create an eligible Ubuntu VM and secure network access | Not completed: Azure alternatives are subscription-restricted; AWS launch stopped before resource creation because tax treatment could not be verified. |
| Demonstrate Linux CLI, users, groups, permissions, processes, services, and SSH | Not executed: deployment stopped at the AWS tax/cost gate before a VM was created. |
| Install Nginx and verify local/external HTTP 200, DNS, and firewall | Not executed: no VM or endpoint existed. |

No VM, SSH, Linux, DNS, firewall, or HTTP tests were performed. No screenshot of a live Module 02 page exists. The existing Nginx and verification scripts remain procedures, not execution evidence.

### Cleanup

The dedicated Azure resource group internship-m02-demo was confirmed absent on 2026-11-09. The AWS preflight on 2026-11-10 created no EC2 instance, EBS volume, public IP, key pair, or security group, so no AWS cleanup was needed. The earlier Azure SSH key was removed. Existing OCI resources and VIRTUPRO/DICSAR infrastructure were not modified.

See [CLEANUP.md](CLEANUP.md) for the cleanup record and safe procedure.

## Repository files

- scripts/setup-nginx.sh installs Nginx and UFW on Ubuntu, restricts SSH to the supplied client CIDR, and publishes the module page. It was not run on a VM in this execution.
- scripts/verify.sh contains the Linux, service, DNS, network, and HTTP checks. It was not run because no VM was created.
- evidence/ contains sanitized real preflight, capacity, restriction, AWS cost-gate, and cleanup outputs. It contains no fabricated VM logs or runtime screenshots.
