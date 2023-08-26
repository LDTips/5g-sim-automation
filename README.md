# 5g-sim-automation
A project that uses a GUI and Ansible (with Jinja2) to:
 - Make the user define the simulation scenario
 - Install Open5Gs and UERANSIM on specific VMs depending on the chosen configuration
 - Template config files for these simulators using Jinja2
 - Provide neccessary tools (bash scripts) for user to start the simulation and gather data from them

The machines should be created on openstack or oracle vm virtualbox beforehand. Inventory file specification is required
