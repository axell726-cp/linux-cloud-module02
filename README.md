# linux-cloud-module02

Beginner internship module: Linux, networking, and cloud infrastructure (Day 6-Day 10).

## Latest execution status — AWS execution 2026-11-10

**Completed with verified cleanup.** One Canonical Ubuntu 24.04 `t3.micro` ran in `us-east-1` for about 8 minutes. SSH key access restricted to the client `/32`, Linux users/groups/permissions/processes/services, IP/routing, DNS, UFW, Nginx, and local plus external HTTP 200 were verified with real commands. The instance is `terminated`; its root EBS volume, ENI, security group, and key pair are absent, with no EIP or snapshot remaining. See [the AWS execution evidence](evidence/aws-execution-20261110/).

The OCI and Azure records remain historical capacity and eligibility blockers: [OCI](evidence/oci-preflight-20261105.md), [Azure B1s](evidence/azure-capacity-attempt-20261105.md), [Azure alternative SKUs](evidence/azure-alternative-skus-20261105.md), and [Azure SKU recheck](evidence/azure-sku-recheck-20261109.md). The [initial AWS cost/tax preflight](evidence/aws-preflight-20261110.md) records the original stop; the later authorized AWS execution and cleanup are documented separately in [evidence/aws-execution-20261110/](evidence/aws-execution-20261110/).

### Provider results

| Provider/location | Result |
| --- | --- |
| OCI, us-ashburn-1 | Historical preflight: Always Free E2.1.Micro allowance was used; A1.Flex host capacity was unavailable in all three availability domains. No OCI resources were created. OCI was not retried. |
| Azure, East US | Resource policy denied the attempted network security group because East US was not an allowed deployment region. East US was not retried. |
| Azure, Chile Central | Earlier B1s request failed host capacity. The 2026-11-09 SKU API recheck marks B1ms and B2s NotAvailableForSubscription. |
| Azure, West US | Earlier B1s request failed host capacity. The 2026-11-09 SKU API recheck marks B1ms and B2s NotAvailableForSubscription. |
| Azure, Canada Central | Earlier B1s request failed host capacity. The 2026-11-09 SKU API recheck marks B1ms and B2s NotAvailableForSubscription. |
| AWS, us-east-1 | One temporary Ubuntu `t3.micro` ran the Module 02 checks; the instance and every run-created resource were removed and verified absent. |

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

No verified tax registration or contact country was returned in the initial preflight. Cost Explorer's zero historical tax records did not establish future tax exemption. AWS promotional credits do not offset transaction-based taxes; AWS states that 18% VAT applies to Peru B2C accounts. This initial check stopped before resource creation. After the user explicitly authorized up to USD 0.10 of potential out-of-pocket tax, the temporary AWS execution below proceeded. See [AWS promotional credit terms](https://aws.amazon.com/awscredits/), [AWS Peru tax guidance](https://aws.amazon.com/tax-help/peru/), [EC2 pricing](https://aws.amazon.com/ec2/pricing/on-demand/), [EBS pricing](https://aws.amazon.com/ebs/pricing/), and [VPC pricing](https://aws.amazon.com/vpc/pricing/).

### AWS execution after explicit authorization — 2026-11-10

The user authorized up to USD 0.50 in promotional credits and USD 0.10 for possible out-of-pocket taxes. One Canonical Ubuntu 24.04 `t3.micro` used an encrypted 8-GiB gp3 root volume, an ephemeral public IPv4, and an isolated security group. SSH was limited to the current client `/32`; TCP 80 was open for the demo. A 20-minute systemd boot timer initiated shutdown, and EC2 was configured to terminate on guest shutdown; both controls were verified before testing. The VM ran for about 8 minutes and was manually terminated immediately after the tests.

The existing `scripts/setup-nginx.sh` installed Nginx and UFW and served the Module 02 page. Over SSH, real checks covered Linux identity and files, a demo user and group, ownership/mode and denied access, processes, `systemctl`, IP addressing, routes, DNS, UFW, listening ports, and local HTTP 200. The Windows client received external HTTP 200. Logs, redacted network rules, state evidence, manifests, and cleanup verification are in [evidence/aws-execution-20261110/](evidence/aws-execution-20261110/). `scripts/verify.sh` was transferred but not invoked verbatim; its relevant checks were run in the captured SSH session. A browser screenshot could not be captured because the in-app browser blocked the temporary raw-IP URL; this is recorded in `07-screenshot-note.txt`.

The one-hour conservative estimate was USD 0.106277 before tax for compute, 8-GiB gp3, one public IPv4, and 1 GB egress. A 100% service reserve plus illustrative 18% tax gives USD 0.250813 total, within the authorized estimates. This is not a final bill or a hard cap. No final billing amount was available at cleanup; billing data may lag. The actual instance runtime was about 8 minutes.

### Objective status

| Objective | Status |
| --- | --- |
| Create an eligible Ubuntu VM and secure network access | Completed and cleaned: Canonical Ubuntu 24.04 `t3.micro`, SSH `/32`, HTTP 80, isolated SG, encrypted 8-GiB gp3 root disk. |
| Demonstrate Linux CLI, users, groups, permissions, processes, services, and SSH | Completed with live SSH tests on Ubuntu; outputs are saved in the AWS execution evidence. |
| Install Nginx and verify local/external HTTP 200, DNS, and firewall | Completed: Nginx active; local and external HTTP 200; DNS, UFW, and security-group rules verified. |

The AWS run includes real SSH, Linux, networking, firewall, service, and HTTP command outputs. No browser screenshot is included because the in-app browser blocked the temporary raw-IP page; the external HTTP 200 was captured from the Windows client.

### Cleanup

The AWS execution on 2026-11-10 terminated the exact instance and verified the root volume, ENI, security group, and key pair absent; the instance had no Elastic IP and created no snapshot. A preceding local CLI setup attempt created only a temporary security group and key pair, both removed and verified absent. Azure resource group internship-m02-demo remained absent per the November 9 check. The existing default VPC/subnet were read-only; OCI, VIRTUPRO/DICSAR, and other projects were not modified. Billing may lag, so no final zero-cost claim is made.

See [CLEANUP.md](CLEANUP.md) for the cleanup record and safe procedure.

## Repository files

- `scripts/setup-nginx.sh` was run on the temporary Ubuntu VM and installed Nginx/UFW, published the page, and verified local HTTP 200.
- `scripts/verify.sh` was transferred but not invoked verbatim; the live checks are recorded in the SSH evidence.
- `evidence/aws-execution-20261110/` contains sanitized real AWS, Linux, SSH, Nginx, HTTP, cost-estimate, and cleanup evidence. It contains no private key or home IP; no browser screenshot was captured.
