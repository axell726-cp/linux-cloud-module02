# Cleanup record and procedure

## Azure cleanup — 2026-11-05

The Azure fallback did not create a VM. Standard_B1s capacity validation failed in Chile Central, West US, and Canada Central before compute provisioning. No managed OS disk was created.

Temporary networking was created only inside the isolated resource group internship-m02-demo. Before each regional move and after the final failure, the group inventory was checked against the unique run tag and the expected four network resources. The entire group was deleted each time. Final verification showed:

- The resource group no longer exists.
- A subscription-wide resource query for the run tag or the expected VM, NIC, public IP, VNet, and NSG names returned zero.
- The matching VM count was zero.
- The matching managed disk count was zero.
- The ephemeral SSH key pair created for this attempt was deleted locally.

The conservative estimate for the three short-lived Standard IPv4 allocations is at most USD 0.015 when budgeting one full hour per IP. No VM, disk, or workload data transfer was created. This is an estimate, not a posted invoice. Azure usage data can arrive after resource deletion; check Cost Management after its data refresh and do not infer zero charges from an empty resource inventory.

No pre-existing shared resources were deleted or changed. OCI was not retried, and VIRTUPRO/DICSAR resources were not touched.

## Safe procedure for a future Azure run

1. Save the real SSH, Linux, service, DNS, firewall, and HTTP evidence before deletion.
2. Read the resource group tags and full inventory. Delete the group only if its unique run tag matches that run and every resource is confirmed as part of that run.
3. Remove the exact temporary group, then verify the group is absent.
4. Search at subscription scope for the unique run tag and expected resource names; verify no VM, managed disk, public IP, NIC, NSG, or VNet remains.
5. Remove only the temporary SSH key generated for that run.
6. Review Cost Management after usage data refresh. An empty resource list is not proof of zero charges.

Never delete resources by broad name prefix or subscription-wide search results. Do not remove or change the subscription spending limit to continue a deployment.

## OCI historical cleanup record and procedure

The 2026-11-05 OCI preflight stopped before provisioning. It created no VM, boot volume, subnet, NSG, public IP, route table, or security list. Existing OCI resources with the internship-m02 prefix were not created by that run and must not be deleted.

For any future OCI deployment, keep exact resource OCIDs in a local, untracked run manifest. Do not commit OCIDs, public IPs, private keys, tenancy IDs, or raw OCI responses. Before each delete, fetch the exact resource and verify its run-specific display name, creation time, and type against the manifest.

If a future run created the following resources, delete only the exact recorded identifiers and in dependency order:

1. Terminate the exact instance and request deletion of its boot volume.
2. Confirm the instance is TERMINATED and its VNIC/public IP has been released. If the exact boot volume remains, delete only its recorded OCID.
3. Delete the run's NSG after the instance and VNIC are gone.
4. Delete the run's subnet, then its route table and security list if that run created them and they are no longer attached.
5. Verify each exact OCID is absent with the corresponding OCI get/list operation.

Do not delete an existing VCN, Internet Gateway, DNS resolver/view, or any other resource that the run did not create. Prefer an ephemeral public IP for a temporary exercise. Resource listings verify cleanup, not final billing.
