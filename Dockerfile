# Use Debian with root access
FROM debian:bookworm

# Avoid interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive
ENV PASSWORD=Devil444

# Install basic tools and Python 3.11
RUN apt update && apt install -y \
    sudo \
    curl \
    wget \
    git \
    unzip \
    gnupg \
    ca-certificates \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3-pip \
    build-essential

# Symlink python3 and pip
RUN ln -sf /usr/bin/python3.11 /usr/bin/python3 && ln -sf /usr/bin/pip3 /usr/bin/pip

# Add new user with sudo privileges
RUN useradd -m coder && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to coder user and install code-server
USER coder
WORKDIR /home/coder

# Download and install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create project directory
RUN mkdir -p /home/coder/project
WORKDIR /home/coder/project

# Expose default code-server port
EXPOSE 8080

# Run code-server with password
CMD ["code-server", "--auth", "password", "--bind-addr", "0.0.0.0:8080"]
