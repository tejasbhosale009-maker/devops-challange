resource "null_resource" "install_minikube" {
  provisioner "local-exec" {
    command = <<EOT
      # Check if Minikube is already running
      if minikube status >/dev/null 2>&1 && [[ $(minikube status --format '{{.Host}}') == "Running" ]]; then
        echo "Minikube is already running. Skipping start."
      else
        echo "Installing Minikube..."
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
        echo "Minikube installation completed."

        echo "Starting Minikube..."
        minikube start --driver=${var.driver} --memory=${var.memory} --cpus=${var.cpus}
      fi
    EOT
  }
}
