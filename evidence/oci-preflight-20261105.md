# OCI preflight evidence - 2026-11-05

Evidence type: sanitized summary of live OCI CLI/API responses. This is not a VM execution log. Account identifiers, resource OCIDs, display names, IP addresses, credential paths, and keys were omitted.

## Authentication and region

- `oci iam tenancy get` succeeded with the existing profile.
- `oci iam region-subscription list` succeeded; the home-region subscription was `READY`.
- The configured region and the tenancy home region both resolve to `us-ashburn-1`.

## Current Always Free usage and capacity

| Resource | Live result |
| --- | --- |
| E2.1.Micro | 2 existing instances active; quota API: 2 used, 0 available |
| A1.Flex regional allowance | 2 OCPUs and 12 GB memory available |
| A1.Flex host capacity for 1 OCPU / 6 GB | `OUT_OF_HOST_CAPACITY` in AD-1, AD-2, and AD-3 |
| Always Free block volume | 144 GB used / 200 GB allowance; 56 GB available |
| Existing VCN inventory | 2 VCNs found; no VCN was created or changed |

The attempted A1 checks were capacity reports only; no instance launch was attempted. The E2 free instance allowance was already exhausted, so no E2 launch was attempted.

## Deployment and test status

- No VM, boot volume, NSG, subnet, public IP, route table, or security list was created for this run.
- No SSH, Linux, Nginx, local HTTP, or external HTTP test was run.
- No deployment cleanup was required. Pre-existing OCI resources, including resources with the `internship-m02` prefix, were left untouched.
- The current client IPv4 was resolved for a possible `/32` SSH rule but was not stored here.
- No claim is made about total tenancy billing or costs from unrelated resources.
