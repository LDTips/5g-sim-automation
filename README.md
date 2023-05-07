# 5g-sim-automation
A project that uses a GUI and Ansible (with Jinja2) to:
 - Make the user define the simulation scenario or machines to create
 - Deploy VMs on Openstack and provide connectivity to them with SSH
 - Install Open5Gs and UERANSIM on specific VMs depending on the chosen configuration
 - Template config files for these simulators using Jinja2
 - Provide neccessary tools (bash scripts) for user to start the simulation and gather data from them


## GUI
Allows the user to deploy either a preconfigured simulation scenario, or clean Open5Gs/UERANSIM machines with optional MongoDB installation (only for Open5Gs).
The latter is called the "custom" case and requires the user to provide their own configuration files for the simulators.
Preconfigured sim scenarios have configuration done automatially

### Technical implementation details
The GUI itself is implemented in Tkinter using object oriented approach.

When the GUI window is launched, user will enter some data and after clicking submit in either of the two categories (predefined, custom),
a 'var_array' will be filled with with the information user has input. 

Based on that, Ansible playbooks will be launched with proper configuration and variables to create and configure VMs as the user requested.

## Ansible automation
Still evolving ansible role that so far has tasks for installing Open5Gs, MongoDB and UERANSIM.

Depending on the machine, chosen tasks will be run.

Templating configs is yet to be implemented and the complexity of the possible templates is to be determined.

More advanced host specifying is also to be implemented. When we create VMs with openstack ansible, we also need a proper host list to connect to the machines