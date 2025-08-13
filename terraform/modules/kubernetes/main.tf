resource "null_resource" "install_minikube" {
  provisioner "local-exec" {
    command = <<EOT
    echo "install minikube"
#    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
#    sudo install minikube-darwin-amd64 /usr/local/bin/minikube
    echo "Minikube installation completed."

      echo "Starting Minikube..."
      minikube start --driver=${var.driver} --memory=${var.memory} --cpus=${var.cpus}

    EOT
  }
}
