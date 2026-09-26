FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install system packages
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

# Install latest Ansible from PyPI
RUN python3 -m pip install --break-system-packages --no-cache-dir ansible

# Configure SSH server
RUN mkdir -p /run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create Ansible working directory
WORKDIR /ansible

# Verify installations
RUN python3 --version && \
    pip3 --version && \
    ansible --version && \
    ssh -V

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
