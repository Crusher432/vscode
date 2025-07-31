FROM codercom/code-server:latest

# Install Python 3.11 and pip
RUN sudo apt-get update && \
    sudo apt-get install -y software-properties-common && \
    sudo add-apt-repository ppa:deadsnakes/ppa && \
    sudo apt-get update && \
    sudo apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip && \
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    sudo ln -sf /usr/bin/python3.11 /usr/bin/python3 && \
    pip install --upgrade pip

# Preinstall common AI & agentic packages
RUN pip install --no-cache-dir \
    torch torchvision torchaudio \
    transformers \
    langchain \
    openai \
    tiktoken \
    requests \
    beautifulsoup4 \
    numpy pandas matplotlib \
    llama-index \
    agentic \
    rich

# Install GitHub Copilot Extension (unofficial support via VS Code extension)
RUN code-server --install-extension GitHub.copilot

# Set password and expose port
ENV PASSWORD="Devil444"
EXPOSE 8080

# Add startup script
COPY startup.sh /home/coder/startup.sh
RUN chmod +x /home/coder/startup.sh

CMD ["/home/coder/startup.sh"]
