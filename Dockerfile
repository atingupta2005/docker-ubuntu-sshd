# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV SSH_USERNAME=ubuntu
ENV PASSWORD=changeme

# Install OpenSSH server and clean up
RUN apt-get update \
    && apt-get install -y openssh-server iputils-ping telnet iproute2\
    && apt-get clean \
    && apt-get -y install sudo \
    && apt-get -y install curl wget nano vim gnupg\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create the privilege separation directory and fix permissions
RUN mkdir -p /run/sshd \
    && chmod 755 /run/sshd

# Expose SSH port
EXPOSE 22

# Create the non-root user with the ability to set a password and authorized keys using environment variables
RUN useradd -ms /bin/bash $SSH_USERNAME

# Set up SSH configuration
RUN mkdir -p /home/$SSH_USERNAME/.ssh && chown $SSH_USERNAME:$SSH_USERNAME /home/$SSH_USERNAME/.ssh \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Copy the script to configure the user's password and authorized keys
COPY configure-ssh-user.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/configure-ssh-user.sh
RUN apt update
RUN apt install -y vim nano tree

# Start SSH server
CMD ["/usr/local/bin/configure-ssh-user.sh"]
