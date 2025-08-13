
# Cloud, Terraform, and Kubernetes Best Practices

## 1. Cloud Best Practices (AWS)

### Security
- Enable **MFA** and **role-based access control (RBAC)**.
- Use **least privilege** for IAM roles and users.
- Rotate API keys and credentials regularly.

### Networking
- Isolate resources using **VPCs/subnets**.
- Use **private endpoints** for databases and storage.
- Apply **firewall rules/security groups** to restrict traffic.

### Monitoring & Logging
- Enable **cloud-native logging and monitoring** (CloudWatch, Stackdriver, Azure Monitor).
- Set up **alerts for errors, resource usage, or security events**.
- Use **centralized logging** for multi-account/multi-region setups.


## 2. Terraform Best Practices

### Code Organization
- Use **modules** for reusable components.
- Structure directories by **environment** (dev, staging, prod).
- Keep **state files secure** (use S3, or remote backends).

### Version Control
- Use **semantic versioning for modules**.
- Lock Terraform and provider versions using `required_version` and `required_providers`.

### State Management
- Enable **remote state storage** with **locking** to prevent concurrent modifications.
- Keep sensitive outputs **secret** and avoid printing them in logs.

### Validation & Security
- Run **terraform validate**, **tflint**, and **tfsec** before applying.
- Use **variables for secrets**, **avoid hardcoding values**.


## 3. Kubernetes Best Practices

### Cluster & Namespace Management
- Use **namespaces** for environment isolation.
- Limit **cluster-admin** privileges; assign roles with RBAC.
- Apply **network policies** to restrict pod communication.

### Deployment & Workload
- Use **Deployment and StatefulSet objects** correctly.
- Set **resource requests and limits** for CPU and memory.
- Enable **liveness and readiness probes** for reliability.
- Use **ConfigMaps and Secrets** for configuration and sensitive data.

### Security
- Run containers as **non-root** user.
- Enable **Pod Security Admission** or **Pod Security Standards**.
- Keep images **up-to-date** and scan for vulnerabilities (Trivy, Clair).

### Monitoring & Logging
- Use **Prometheus + Grafana** for metrics.
- Centralize logs using **ELK/EFK stack**.
- Set up **alerting for high CPU, memory, or failed pods**.

### Networking
- Use **CNI plugins** for networking (Calico, Flannel, Cilium).
- Configure **Ingress controllers** and TLS for external traffic.
- Limit public exposure of services.

### Backup & Recovery
- Regularly **backup ETCD** for disaster recovery.
- Use **persistent volume snapshots** for stateful workloads.
