FROM codercom/code-server:latest

# Install Python 3.11 and dev tools (Debian 12 compatible)
RUN sudo apt-get update && \
    sudo apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip && \
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    sudo ln -sf /usr/bin/python3.11 /usr/bin/python3 && \
    python3 --version && pip3 --version && \
    pip3 install --upgrade pip --break-system-packages

# Install AI/Agentic ecosystem packages using --break-system-packages
RUN pip3 install --no-cache-dir \
    torch torchvision torchaudio \
    langchain \
    openai \
    tiktoken \
    llama-index \
    transformers \
    agentic \
    rich \
    numpy pandas requests \
    --break-system-packages

# VSCode Extensions (optional)
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension GitHub.copilot

# Expose port and set password
ENV PASSWORD="Devil444"
EXPOSE 8080

# Startup script
COPY startup.sh /home/coder/startup.sh
RUN chmod +x /home/coder/startup.sh

CMD ["/home/coder/startup.sh"]
