resource "local_file" "inventory" {
  filename = "../kubesprey/inventory/sample/inventory"
  content  = templatefile("ansible-inventory.tpl", { master = yandex_compute_instance.master, worker = yandex_compute_instance.worker, username = var.user_name })
}

resource "local_file" "group_vars_file" {
  filename = "../kubesprey/ansible-kubsprey-vars.yaml"
  content  = templatefile("ansbile-kubsprey-config.tpl", { master = yandex_compute_instance.master}) 
}

resource "time_sleep" "wait_for_resource" {
  create_duration = "30s" # Wait for 60 seconds during creation
  # Optional: destroy_duration = "30s" # Wait for 30 seconds during destruction
  depends_on = [yandex_compute_instance.master, yandex_compute_instance.worker] # Ensures the wait happens after my_server is created
}

resource "null_resource" "vars_kubesprey" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../kubesprey/inventory/sample/inventory ../kubesprey/ansible-kubsprey-vars.yaml -b -v"
  }
  depends_on = [time_sleep.wait_for_resource]
}

resource "null_resource" "deploy-k8s" {

  #Запуск ansible-playbook
  provisioner "local-exec" {
    
    # without secrets
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../kubesprey/inventory/sample/inventory  ../kubesprey/cluster.yml -b -v"

  }
  depends_on = [null_resource.vars_kubesprey]
 }

resource "null_resource" "kube-config" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../kubesprey/inventory/sample/inventory ./playbook-kubeconf.yaml -b -v"
  }
  depends_on = [null_resource.deploy-k8s]
}
