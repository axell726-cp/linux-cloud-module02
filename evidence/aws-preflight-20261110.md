# AWS preflight — 2026-11-10

Run identifier: aws-m02-preflight-20261110-01
Status: BLOCKED before deployment. No resource-creation call was sent.

## Authentication, credits, and coverage

AWS CLI 2.36.39 authenticated successfully with STS. Account identifiers are omitted.

The Free Tier API returned:

    accountPlanType: PAID
    accountPlanStatus: ACTIVE
    accountPlanRemainingCredits: USD 53.15

Billing GetCredits returned five enabled Promotion records. Aggregated values:

    remainingAmount as of last completed billing: USD 65.76
    estimatedAmount for current billing: USD 53.15
    credit expiration: 2027-10-03

Each active credit included these required products:

    Amazon Elastic Compute Cloud
    Amazon Virtual Private Cloud
    AWS Data Transfer

This confirms coverage for EC2 compute/EBS, the public IPv4 service, and internet data transfer. Credit IDs and account identifiers are omitted.

## EC2, quota, image, and network checks

    t3.micro offered in us-east-1: true
    t3.micro: 2 vCPU, 1024 MiB, x86_64
    Running On-Demand Standard EC2 quota: 16
    Existing EC2 inventory in us-east-1: empty
    Canonical Ubuntu 24.04 AMI parameter resolved successfully
    Existing default VPC: available
    Public subnets: six available, auto-assign public IPv4 enabled
    Default route: 0.0.0.0/0 to an attached Internet Gateway, active

Existing VPC, subnet, route, and Internet Gateway IDs are omitted. No existing networking configuration was changed.

## Price estimate

AWS Price List API returned:

    Linux t3.micro: USD 0.0104 per hour
    gp3 EBS: USD 0.08 per GB-month

AWS VPC pricing lists a public IPv4 at USD 0.005 per hour. The egress estimate uses USD 0.09 per GB and assumes the monthly free transfer allowance has already been consumed.

A local Python calculation estimated one hour of t3.micro, an 8-GiB gp3 root disk, one public IPv4, and 1 GB egress:

    pre-tax subtotal: USD 0.106277
    100% reserve: USD 0.106277
    illustrative 18% tax scenario on reserved amount: USD 0.038260
    gross estimate under that tax scenario: USD 0.250813

This is a conservative estimate, not a posted charge or a hard cap.

## Tax and stop condition

AWS promotional credit terms exclude transaction-based taxes. AWS Tax Settings GetTaxRegistration returned ResourceNotFoundException; no verified tax registration was available. The installed AWS CLI did not support get-primary-contact, so the account contact country could not be read. The AWS Billing console opened to an IAM sign-in page; no username, password, or other secret was entered.

Cost Explorer returned USD 0 in Tax record type for 2026-10-01 through 2026-10-31 and 2026-11-01 through 2026-11-09. Billing data can lag, and these historical values do not establish future tax exemption. AWS states that accounts located in Peru incur 18% VAT for B2C customers without a valid tax registration. The account tax location and tax treatment therefore could not be verified, so the no-out-of-pocket requirement was not satisfied.

## Resources, execution, and cleanup

    RunInstances requests: 0
    New security groups: 0
    New key pairs: 0
    New EBS volumes: 0
    New public IPv4 addresses: 0
    Created resource IDs: none
    Cleanup actions required: none

No SSH key or local resource manifest containing cloud IDs was generated. No Linux, SSH, firewall, Nginx, DNS, or HTTP tests ran. There is no EC2-running, SSH, Nginx, or HTTP screenshot. No AWS resource was created, changed, or deleted; the existing VPC was inspected read-only.

Sources:
- AWS Promotional Credit terms: https://aws.amazon.com/awscredits/
- AWS Peru tax help: https://aws.amazon.com/tax-help/peru/
- AWS EC2 pricing: https://aws.amazon.com/ec2/pricing/on-demand/
- AWS EBS pricing: https://aws.amazon.com/ebs/pricing/
- AWS VPC pricing: https://aws.amazon.com/vpc/pricing/
- AWS credit API details: https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/useconsolidatedbilling-credits.html
