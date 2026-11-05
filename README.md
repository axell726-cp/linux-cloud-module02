# linux-cloud-module02

Beginner internship module: Linux, networking, and cloud infrastructure (Day 6-Day 10).

## Execution status - 2026-11-05

**Blocked before deployment.** Live OCI checks found no Always Free compute capacity for a temporary Ubuntu VM. No instance, boot volume, subnet, NSG, public IP, or Nginx service was created for this run. Existing OCI resources were left untouched.

Scripts in this repository are prepared procedures. Their presence does not mean that the Linux or HTTP objectives were executed.

### Live preflight

- OCI API authentication succeeded using the existing local profile. The configured region is the tenancy home region, `us-ashburn-1`; its subscription status is `READY`.
- `VM.Standard.E2.1.Micro`: both Always Free instance slots are already in use by two running instances. The live quota response reported 2 used and 0 available.
- `VM.Standard.A1.Flex` fallback: live regional quotas showed 2 OCPUs and 12 GB memory available. Capacity reports for a 1 OCPU / 6 GB Ubuntu VM returned `OUT_OF_HOST_CAPACITY` in all three Ashburn availability domains.
- Block volume: 144 GB used out of the 200 GB Always Free regional allowance; 56 GB remained. A 50 GB boot volume would fit, leaving 6 GB, but none was created.
- OCI Resource Search showed two existing VCNs and pre-existing resources carrying the `internship-m02` prefix. They were not modified or deleted. No new VCN or network resources were created.
- The client IPv4 address was resolved for a potential SSH `/32` rule and deliberately omitted from this repository.

The detailed, sanitized API summary is in [evidence/oci-preflight-20261105.md](evidence/oci-preflight-20261105.md).

### Objective status

| Objective | Status |
| --- | --- |
| Create an eligible Ubuntu VM and secure network access | Not completed; no free host capacity |
| Demonstrate Linux commands, permissions, users, processes, services, and SSH | Not executed; no VM was available |
| Install Nginx and verify local and external HTTP 200 | Not executed; no VM was available |

No SSH or HTTP test was run. No deployment cleanup was needed because this run created no infrastructure. This report does not make a claim about charges from other resources in the tenancy.

## Intended architecture

Client -- TCP 22 from the current client IPv4 `/32`, TCP 80 public -- temporary Ubuntu VM -- Nginx.

Use only an Always Free eligible shape and image in the tenancy home region. Recheck capacity and storage before any future attempt. Do not upgrade the account, use credits, or change an existing project to make capacity.

## Repository files

- `scripts/setup-nginx.sh` installs and starts Nginx on Ubuntu.
- `scripts/verify.sh` checks local Linux, service, DNS, port, and HTTP status.
- `CLEANUP.md` describes exact-ID cleanup for resources created by a future run. The current blocked run has nothing to clean up.
- `evidence/` contains sanitized evidence. It does not contain instance logs because no instance was created.

## Cost and eligibility notes

Oracle documents up to two Always Free E2.1.Micro instances, the A1 allowance, and 200 GB of combined boot and block volume storage in the home region. Free resources are subject to capacity. See [Oracle Always Free resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm) and the [OCI capacity report command](https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/oci_cli_docs/cmdref/compute/compute-capacity-report/create.html).

The capacity report is the reason this run stopped; it is not evidence that the deployment objectives are complete.
