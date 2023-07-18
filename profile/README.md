# n3t.uk Organisation

The `n3tuk` Organisation is a central organisation within GitHub for the
management and development of the infrastructure for `n3t.uk`, which includes:

- Privately-hosted Kubernetes Cluster on Intel NUCs;
- CloudFlare DNS and Zero-Trust networking;
- AWS Accounts and Services; and
- Testing and development applications and service.

## Diagram

![Network Diagram (Light Mode)](https://github.com/n3tuk/.github/blob/main/images/network-light.svg#gh-light-mode-only)
![Network Diagram (Dark Mode)](https://github.com/n3tuk/.github/blob/main/images/network-dark.svg#gh-dark-mode-only)

## Components

There are a number of components used to build and develop this infrastructure:

- [`ansible`][github-ansible]: An [`ansible`][ansible] repository for the
  [bootstrap][bootstrap] installation, [baseline][baseline] setup, and
  [management][all] of physical and virtual servers and their services, such as
  [`vault`][vault], [`consul`][consul], [`etcd`][etcd], and of
  [`kubernetes`][kubernetes] itself.
- `terraform`: Multiple repositories based upon templates for Terraform
  [modules][modules] and [configurations][configurations], and kept up-to-date
  with the upstream repositories through a custom GitHub Action
  ([`action-synchronize-upstream`][action-synchronise]).

[ansible]: https://www.ansible.com/
[github-ansible]: https://github.com/n3tuk/ansible
[bootstrap]: https://github.com/n3tuk/ansible/blob/main/plays/bootstrap.yaml
[baseline]: https://github.com/n3tuk/ansible/blob/main/plays/baseline.yaml
[all]: https://github.com/n3tuk/ansible/blob/main/plays/all.yaml
[vault]: https://github.com/n3tuk/ansible/tree/main/roles/vault
[consul]: https://github.com/n3tuk/ansible/tree/main/roles/consul
[etcd]: https://github.com/n3tuk/ansible/tree/main/plays/roles/etcd
[kubernetes]: https://github.com/n3tuk/ansible/tree/main/roles/kubernetes
[modules]: https://github.com/n3tuk/template-terraform-module
[configurations]: https://github.com/n3tuk/template-terraform-configuration
[action-synchronise]: https://github.com/n3tuk/action-synchronise-upstream
