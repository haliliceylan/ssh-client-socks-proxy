# Use a lightweight base image with an SSH client installed
FROM alpine:latest

# Install necessary packages
RUN apk update && \
    apk add --no-cache openssh-client sshpass

# Set environment variables for SSH connection
ENV SSH_HOST=changeme
ENV SSH_PORT=22
ENV SSH_USER=changeme
ENV SSH_PASSWORD=changeme

# Expose the SOCKS proxy port
ENV SOCKS_PORT=1080
EXPOSE $SOCKS_PORT

# Copy script to connect and create the SOCKS proxy
COPY start-ssh-socks-proxy.sh /usr/local/bin/

# Set execute permissions
RUN chmod +x /usr/local/bin/start-ssh-socks-proxy.sh

# Health check to ensure the proxy port is available
HEALTHCHECK --interval=30s --timeout=10s CMD nc -zv localhost $SOCKS_PORT || exit 1

# Start the SOCKS proxy on container startup
CMD ["/usr/local/bin/start-ssh-socks-proxy.sh"]