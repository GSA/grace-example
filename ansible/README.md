## GRACE Example Ansible Playbooks and Roles

### Jumphost

Playbook used by Packer template to provision users and groups.  SSH public keys are stored in `ansible/roles` directory.  Depends on [`sansible.users_and_groups`](https://galaxy.ansible.com/sansible/users_and_groups) role.