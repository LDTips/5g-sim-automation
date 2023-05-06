# sim_GUI
A front-end for the [ansible vm automation](https://github.com/LDTips/ansible-vm-automation)

Allows the user to deploy either a preconfigured simulation scenario, or clean Open5Gs/UERANSIM machines with optional MongoDB installation (only for Open5Gs).
The latter is called the "custom" case and requires manual configuration from the user. Preconfigured sim scenarios have configuration done automatially

## GUI architecture
The GUI itself is implemented in Tkinter using object oriented approach.
When the GUI window is launched, user will enter some data and after clicking submit in either of the two categories (predefined, custom),
a 'var_array' will be filled with with the information user has input. 

Based on that, Ansible playbooks will be launched with proper configuration and variables to create and configure VMs as the user requested.
