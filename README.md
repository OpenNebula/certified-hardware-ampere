**TBA-cloud-provider**: logos of OpenNebula and the Cloud Provider

# Deploying OpenNebula on Ampere Hardware

This repository contains the needed code and documentation to perform an OpenNebula deployment and configuration on Ampere hardware. It extends the [one-deploy-validation](https://github.com/OpenNebula/one-deploy-validation) repository, which is added as a git submodule.

- [Requirements](#requirements)
- [Hardware Specifications](#hardware-specifications)
- [Required Parameters](#required-parameters)
- [Deployment and Verification](#deployment-and-verification)

## Requirements

1. Install `hatch`

   ```shell
   pip install hatch
   ```

1. Initialize the dependent `one-deploy-validation` submodule

   ```shell
   git submodule update --init --remote --merge
   ```

1. Install the `opennebula.deploy` collection with dependencies using the submodule's tooling:

   ```shell
   make submodule-requirements
   ```

## Hardware Specifications

See the details of the Ampere servers that has been used to certify the hardware platform for OpenNebula deployment: [Ampere OpenNebula](https://docs.opennebula.io/7.0/solutions/certified_hw_platforms/ampere_opennebula/). 
After the servers have been provisioned, take note of the required parameters that are required for automation of OpenNebula deployment and verification.

## Required Parameters

Update the [inventory](./inventory/) values to match the provisioned infrastructure.

| Description                                 | Variable Names                      | Files/Location                                      |
|---------------------------------------------|-------------------------------------|-----------------------------------------------------|
| Frontend Host IP                            | `ansible_host`                      | [inventory/ampere.yml](./inventory/)    | 
| KVM Host IPs                            | `ansible_host`                      | [inventory/ampere.yml](./inventory/)     | 
| VXLAN PHYDEV                                 | `vn.vxlan.template.PHYDEV`          | [inventory/ampere.yml](./inventory/)                               | 
| GUI password of `oneadmin`       | `one_pass` | [inventory/*.yml](./inventory/)           | 

**Optional customization parameters**:
| Description                                 | Variable Names                      | Files/Location                                      |
|---------------------------------------------|-------------------------------------|-----------------------------------------------------|
| VXLAN Starting IP                                 | `vn.vxlan.template.AR.IP`          | [inventory/ampere.yml](./inventory/)                               | 
| VXLAN IP range size                                 | `vn.vxlan.template.AR.SIZE`          | [inventory/ampere.yml](./inventory/)                               | 

## Deployment and Verification

Use the provided Makefile commands to automate deployment and testing:

1. Review the [inventory](./inventory/) and [playbooks](./playbooks/) directories, following Ansible design guidelines.

1. Deploy OpenNebula:

   ```shell
   make deployment
   ```

1. Configure the deployment for the specifics of ARM64 architecture of Ampere servers:

   ```shell
   make specifics
   ```

1. Verify the deployment:

   ```shell
   make verification
   ```

For more information about the submodule's tooling, refer to its [README.md](https://github.com/OpenNebula/one-deploy-validation/blob/master/README.md) and for detailed documentation on the deployment automation refer to the [one-deploy repo](https://github.com/OpenNebula/one-deploy).


