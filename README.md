# linux-cloud-module02

Beginner internship module: Linux, networking, and cloud infrastructure (Day 6-Day 10).

## Execution status — 2026-11-05

**Not completed.** Azure for Students was selected after the historical OCI capacity blocker, but Azure rejected the Ubuntu B1s VM request for host capacity in three policy-approved regions. No VM or managed OS disk was created. The Linux, SSH, Nginx, DNS, firewall, and HTTP objectives therefore remain unexecuted.

The Azure and OCI records are separate: [evidence/oci-preflight-20261105.md](evidence/oci-preflight-20261105.md) is the historical OCI capacity check; [evidence/azure-capacity-attempt-20261105.md](evidence/azure-capacity-attempt-20261105.md) records the later Azure attempts and verified cleanup. Neither file claims successful Linux or web-server execution.

### Provider results

| Provider/location | Result |
| --- | --- |
| OCI, us-ashburn-1 | Historical preflight: Always Free E2.1.Micro allowance was used; A1.Flex host capacity was unavailable in all three availability domains. No OCI resources were created. OCI was not retried. |
| Azure, East US | Resource policy denied the attempted network security group because East US was not an allowed deployment region. No East US network resource remained. |
| Azure, Chile Central | Azure returned SkuNotAvailable for Standard_B1s capacity. |
| Azure, West US | Azure returned SkuNotAvailable for Standard_B1s capacity. |
| Azure, Canada Central | Azure returned SkuNotAvailable for Standard_B1s capacity. |

The network-only footprint in each subsequent region was temporary and was deleted before changing regions. In each region, the control-plane check confirmed SSH limited to the current client IPv4 /32 and public TCP 80. This proves the NSG rules were configured; it does not prove SSH or HTTP connectivity.

### Azure eligibility and cost gate

Before VM requests, the Azure CLI authenticated to an enabled Azure for Students subscription. The subscription spending limit was On and was rechecked before each request; it was never removed, and the subscription was not upgraded. The predeployment billing snapshot showed USD 100.00 of promotional credit, not estimated, expiring 2027-09-22 22:35 UTC. Post-run usage can take time to appear, so that snapshot is not a final remaining-balance statement.

The conservative planning estimate for the complete one-hour demonstration was approximately **USD 0.50**, including a 25% reserve and no assumed free-usage allowances:

| Cost item | Estimate used |
| --- | ---: |
| B1s compute, one hour | USD 0.0124 (highest listed rate in the attempted US/Canada regions; Canada Central was USD 0.0116/hour) |
| 32-GiB Standard SSD E4 OS disk, one hour | USD 0.0046, prorated from USD 3.36/month |
| Three temporary Standard IPv4 addresses, one full hour each | USD 0.015 |
| Internet egress, 1 GB | USD 0.087, assuming the monthly free allowance was already consumed |
| Standard SSD operations, 1 million | USD 0.28 |
| Subtotal plus 25% reserve | About USD 0.50 |

These are retail-rate estimates, not posted charges or a hard cap. The actual attempt created only temporary network resources; a conservative estimate for their billable IPv4 time is at most USD 0.015. No VM, managed disk, or workload egress was provisioned. Cost Management can report usage after it occurs, so the final amount must be checked after billing data refreshes. The spending limit remained On and no payment-plan conversion was made.

Pricing references: [Azure for Students offer](https://azure.microsoft.com/en-us/pricing/offers/ms-azr-0170p), [Linux VM pricing and Canonical support](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/), [Azure Retail Prices API](https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices), [managed disks](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types), and [bandwidth pricing](https://azure.microsoft.com/en-us/pricing/details/bandwidth/).

### Objective status

| Objective | Status |
| --- | --- |
| Create Ubuntu VM and secure network access | Not completed: B1s capacity was unavailable in all three attempted allowed regions. All temporary networking was removed. |
| Demonstrate Linux CLI, users, groups, permissions, processes, services, and SSH | Not executed: no VM was available. |
| Install Nginx and verify local/external HTTP 200, DNS, and firewall | Not executed: no VM or endpoint existed. |

No SSH session or DNS/HTTP test ran. No screenshot of a live Module 02 page exists because no VM or Nginx service was created; the evidence directory contains the real capacity and cleanup outputs instead. This distinction is intentional.

### Cleanup

The temporary resource group internship-m02-demo is absent. A subscription-wide search returned zero resources with this run tag or the expected names, zero matching VMs, and zero matching managed disks. The temporary SSH key pair generated for the attempt was removed from the local temporary directory. Existing OCI resources and VIRTUPRO/DICSAR infrastructure were not modified.

See [CLEANUP.md](CLEANUP.md) for the cleanup record and safe procedure.

## Repository files

- scripts/setup-nginx.sh installs Nginx and UFW on Ubuntu, restricts SSH to the supplied client CIDR, and publishes the module page. It was not run on a VM in this execution.
- scripts/verify.sh contains the Linux, service, DNS, network, and HTTP checks. It was not run because no VM was created.
- evidence/ contains sanitized real preflight, failure, and cleanup outputs. It contains no fabricated VM logs or screenshots.
