
[all:vars]

ansible_user=${username}

[kube_control_plane]

%{~ for i in master ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"]} # ip=10.3.0.1 etcd_member_name=etcd1

%{~ endfor ~}

[etcd:children]
kube_control_plane

[kube_node]

%{~ for i in worker ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"]} 

%{~ endfor ~}