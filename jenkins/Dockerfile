FROM jenkins/jenkins:lts

USER root

# Install dependencies
RUN apt-get update && apt-get install -y unzip curl git openssh-client python3-pip
RUN apt-get update && apt-get install -y unzip curl git openssh-client python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
ENV TERRAFORM_VERSION=1.9.6
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip -o terraform.zip -d /usr/local/bin/ \
    && rm terraform.zip

# Install TFLint
ENV TFLINT_VERSION=v0.58.1

RUN curl -fsSL --retry 3 --retry-delay 2 -o /tmp/tflint.zip \
    https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip \
 && unzip -q -o /tmp/tflint.zip -d /usr/local/bin/ \
 && rm /tmp/tflint.zip \
 && chmod +x /usr/local/bin/tflint


# Install tfsec
ENV TFSEC_VERSION=1.28.14
RUN curl -fsSL --retry 3 --retry-delay 2 -o /tmp/tfsec-linux-amd64 \
    https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64 \
    && cp /tmp/tfsec-linux-amd64 /usr/local/bin/tfsec \
    && rm /tmp/tfsec-linux-amd64 \
    && chmod +x /usr/local/bin/tfsec

#install trivy
RUN apt-get update && \
    apt-get install -y wget apt-transport-https gnupg lsb-release && \
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor -o /usr/share/keyrings/trivy.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
        | tee /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y trivy && \
    rm -rf /var/lib/apt/lists/*

#install docker
RUN apt-get update && \
    apt-get install -y docker.io vim && \
    rm -rf /var/lib/apt/lists/*

# Install Helm
USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
# Add Jenkins user local bin to PATH if needed
ENV PATH=$PATH:/usr/local/bin

