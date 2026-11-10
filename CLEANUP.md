# Cleanup record and procedure

## Azure recheck and cleanup — 2026-11-09

The authenticated, read-only SKU query marked Standard_B1ms and Standard_B2s NotAvailableForSubscription in Chile Central, West US, and Canada Central. No VM provisioning request was sent, and this check created no Azure resources. The dedicated resource group internship-m02-demo returned RESOURCE_GROUP_EXISTS=false. No deletion was needed for this run. The active subscription remained Enabled with spendingLimit=On; no billing balance refresh was performed because deployment stopped at the SKU restriction gate.
## Final Azure alternative-SKU preflight — 2026-11-05

No VM provisioning request or new resource creation was made in this preflight. Both Standard_B1ms and Standard_B2s were marked NotAvailableForSubscription in Chile Central, West US, and Canada Central. The available quota did not override those SKU restrictions.

The prior temporary Azure resource group internship-m02-demo was already absent. A fresh subscription-wide search returned zero resources matching the prior run tag or expected VM, NIC, public IP, VNet, and NSG names; the matching VM count was zero. No cleanup action was required for this final preflight.

The earlier B1s attempt had already removed its temporary network resources and SSH key. Its conservative estimated public IPv4 usage remains at most USD 0.015, not a posted charge. Current billing showed USD 100.00 remaining in the active credit lot and USD 0.00 pending eligible charges at the time of the query; usage data can arrive later, so this is not a final zero-cost statement.

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
