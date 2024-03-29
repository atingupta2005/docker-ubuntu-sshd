# SSH-Enabled Ubuntu Docker Image

[![Docker Image Deployment](https://github.com/atingupta2005/ubuntu-sshd/actions/workflows/ci_cd.yml/badge.svg)](https://github.com/atingupta2005/ubuntu-sshd/actions/workflows/ci_cd.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/atingupta2005/ubuntu-sshd.svg)](https://hub.docker.com/r/atingupta2005/ubuntu-sshd)
[![Maintenance](https://img.shields.io/badge/Maintained-Yes-green.svg)](https://github.com/atingupta2005/ubuntu-sshd)

This Docker image provides an Ubuntu 22.04 base with SSH server enabled. It allows you to easily create SSH-accessible containers via SSH keys or with a default username and password.

## Usage

### Cleanup
```
cd ~
sudo rm -rf docker-ubuntu-sshd
docker rm -f ubuntu_ssh_01 ubuntu_ssh_02 ubuntu_ssh_03 ubuntu_ssh_04 ubuntu_ssh_05
```

### Cloning the Repository

To get started, clone the GitHub  [repository](https://github.com/atingupta2005/ubuntu-sshd) containing the Dockerfile and scripts:

```bash
cd ~
git clone https://github.com/atingupta2005/docker-ubuntu-sshd
cd docker-ubuntu-sshd
```

### Building the Docker Image

Buld the Docker image from within the cloned repository directory:

```bash
docker build -t my-ubuntu-sshd:latest .
```

### Running a Container

To run a container based on the image, use the following command:

#### Command Template
```bash
docker run -itd -p 2201:22 --name ubuntu_ssh_01 -e SSH_USERNAME=u01 -e PASSWORD=p -e AUTHORIZED_KEYS="$(cat path/to/authorized_keys_file)" my-ubuntu-sshd:latest
```

#### Sample Command
```bash
docker run -itd -p 2201:22 --name ubuntu_ssh_01 -e SSH_USERNAME=u01 -e PASSWORD=p my-ubuntu-sshd:latest
docker run -itd -p 2202:22 --name ubuntu_ssh_02 -e SSH_USERNAME=u01 -e PASSWORD=p my-ubuntu-sshd:latest
docker run -itd -p 2203:22 --name ubuntu_ssh_03 -e SSH_USERNAME=u01 -e PASSWORD=p my-ubuntu-sshd:latest
docker run -itd -p 2204:22 --name ubuntu_ssh_04 -e SSH_USERNAME=u01 -e PASSWORD=p my-ubuntu-sshd:latest
docker run -itd -p 2205:22 --name ubuntu_ssh_05 -e SSH_USERNAME=u01 -e PASSWORD=p my-ubuntu-sshd:latest
```

- `-d` runs the container in detached mode.
- `-p host-port:22` maps a host port to port 22 in the container. Replace `host-port` with your desired port.
- `-e SSH_USERNAME=myuser` sets the SSH username in the container. Replace `myuser` with your desired username.
- `-e PASSWORD=mysecretpassword` sets the SSH user's password in the container. Replace `mysecretpassword` with your desired password.
- `-e AUTHORIZED_KEYS="$(cat path/to/authorized_keys_file)"` sets authorized SSH keys in the container. Replace `path/to/authorized_keys_file` with the path to your authorized_keys file.
- `my-ubuntu-sshd:latest` should be replaced with your Docker image's name and tag.

### SSH Access

Once the container is running, you can SSH into it using the following command:

```bash
ssh -p 2201 root@localhost
#Password is root
```

- `host-port` should match the port you specified when running the container.
- Use the provided password or SSH key for authentication, depending on your configuration.

### Note

- If the `AUTHORIZED_KEYS` environment variable is empty when starting the container, it will still launch the SSH server, but no authorized keys will be configured. You have to mount your own authorized keys file or manually configure the keys in the container.

## License

This Docker image is provided under the [MIT License](LICENSE).
