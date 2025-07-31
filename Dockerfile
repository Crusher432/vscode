FROM codercom/code-server:latest

# Set environment variable for password login
ENV PASSWORD=Devil444

# Install Python 3.11 directly from apt (available in Debian 12)
RUN sudo apt update && \
    sudo apt install -y python3.11 python3.11-venv python3.11-dev python3-pip && \
    sudo ln -sf /usr/bin/python3.11 /usr/bin/python3 && \
    sudo ln -sf /usr/bin/pip3 /usr/bin/pip && \
    python3 --version && pip3 --version

# Grant full root access to 'coder' user
RUN echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create a working directory
WORKDIR /home/coder/project
