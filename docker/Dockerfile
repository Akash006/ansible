FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        openssh-client \
        openssh-server \
        sshpass \
        curl \
        sudo \
        ca-certificates \
        software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install latest Ansible
RUN python3 -m pip install --break-system-packages --no-cache-dir ansible

# Set root password
RUN echo 'root:Passw0rd' | chpasswd

# Configure SSH
RUN mkdir -p /run/sshd && \
    sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Ansible working directory
WORKDIR /ansible

# Verify installations
RUN python3 --version && \
    ansible --version && \
    ssh -V

EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
