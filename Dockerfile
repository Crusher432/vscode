FROM codercom/code-server:latest

# Set environment variables
ENV PASSWORD=Devil444

# Install Python 3.11 and pip
RUN sudo apt update && \
    sudo apt install -y software-properties-common && \
    sudo add-apt-repository -y ppa:deadsnakes/ppa && \
    sudo apt update && \
    sudo apt install -y python3.11 python3.11-venv python3.11-dev python3-pip && \
    sudo ln -sf python3.11 /usr/bin/python3 && \
    sudo ln -sf pip3 /usr/bin/pip

# Install some dev tools and utilities
RUN sudo apt install -y git curl wget unzip sudo

# Add your user to sudoers (code-server runs as 'coder' user)
RUN echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Optional: Create workspace dir
RUN mkdir -p /home/coder/project
WORKDIR /home/coder/project
