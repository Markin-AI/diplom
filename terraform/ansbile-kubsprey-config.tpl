---
- name: Allow access by public IP
  hosts: localhost
  become: no
  gather_facts: no
  vars:
    ip_list: "{{ groups['kube_control_plane'] | map('extract', hostvars) | map(attribute='ansible_host') | list }}"
    ip_joined: "{{ ip_list | join(',') }}"
  tasks:
      - name: Configure option in k8s-cluster.yml
        replace:
          path: ../kubesprey/inventory/sample/group_vars/k8s_cluster/k8s-cluster.yml
          regexp: '^.*supplementary_addresses_in_ssl_keys:.*'
          replace: "supplementary_addresses_in_ssl_keys: [127.0.0.1, {{ip_joined}}]"