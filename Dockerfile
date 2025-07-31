FROM codercom/code-server:latest

# Install Python 3.11 from Debian backports (no PPA needed)
RUN sudo apt-get update && \
    sudo apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip && \
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    sudo ln -sf /usr/bin/python3.11 /usr/bin/python3 && \
    python3 --version && pip3 --version && \
    pip3 install --upgrade pip

# Install VSCode extensions
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension GitHub.copilot

# Install agentic AI ecosystem
RUN pip install --no-cache-dir \
    torch torchvision torchaudio \
    langchain \
    openai \
    tiktoken \
    llama-index \
    transformers \
    agentic \
    rich \
    numpy pandas requests

# Set password and expose port
ENV PASSWORD="Devil444"
EXPOSE 8080

# Copy startup script
COPY startup.sh /home/coder/startup.sh
RUN chmod +x /home/coder/startup.sh

CMD ["/home/coder/startup.sh"]
