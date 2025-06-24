# CloudeOne

## Overview
<!-- Project description and purpose -->
CloudeOne is an automated WordPress deployment solution using Ansible, Docker, and Vagrant. It creates a fully containerized WordPress environment with Nginx, MySQL, and phpMyAdmin in an isolated virtual machine, making it perfect for development, testing, or production environments.

## Architecture
<!-- Visual representation of system architecture -->
```
+-------------------------------------------------------+
|                  Vagrant VM (192.168.56.23)           |
|                                                       |
|   +-------------------+      +-------------------+    |
|   |                   |      |                   |    |
|   |  Nginx Container  |----->|  WordPress (PHP)  |    |
|   |  (Reverse Proxy)  |      |    Container      |    |
|   |      Port 443     |      |                   |    |
|   +-------------------+      +-------------------+    |
|            |                          |               |
|            |                          |               |
|            v                          v               |
|   +-------------------+      +-------------------+    |
|   |                   |      |                   |    |
|   |  MySQL Container  |<---->|   phpMyAdmin      |    |
|   |  (Database)       |      |   Container       |    |
|   |                   |      |                   |    |
|   +-------------------+      +-------------------+    |
|                                                       |
+-------------------------------------------------------+
          ^
          |
          | Port Forwarding (443 → 4443)
          |
+---------v---------+
|                   |
|   Host Machine    |
|                   |
+-------------------+
```

<!-- Component description -->
The environment consists of the following components:

- **Nginx**: Acts as a reverse proxy, handling SSL termination and serving static content
- **WordPress**: PHP-FPM based WordPress installation
- **MySQL**: Database server for WordPress
- **phpMyAdmin**: Web interface for MySQL database management

All components run in Docker containers on a Vagrant-managed virtual machine.

## Prerequisites
<!-- Required software to run this project -->
- [Vagrant](https://www.vagrantup.com/downloads) (2.2.x or later)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (6.1.x or later)
- [Python](https://www.python.org/downloads/) (3.8.x or later)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (2.17.x or later)

## Quick Start
<!-- Step-by-step installation instructions -->
1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/CloudeOne.git
   cd CloudeOne
   ```
2. Initialize the environment:

   ```bash
   chmod +x init.sh
   ./init.sh
   ```

   This script will:

   - Create and activate a Python virtual environment
   - Start the Vagrant virtual machine
   - Generate and copy SSH keys for passwordless authentication
   - Install required Ansible collections
3. Deploy the WordPress site:

   ```bash
   chmod +x script.sh
   ./script.sh start
   ```
4. Access your site:

   - WordPress: https://192.168.56.23:443

## Configuration
<!-- How to configure the application -->
All configuration is stored in encrypted Ansible vault files:

```bash
# View vault contents (you'll be prompted for the vault password)
ansible-vault view group_vars/all.yaml
```

### Key Configuration Variables
<!-- Important configuration parameters -->
- `WORDPRESS_DB_NAME`: WordPress database name
- `WORDPRESS_DB_USER`: WordPress database username
- `WORDPRESS_DB_PASSWORD`: WordPress database password
- `MYSQL_ROOT_PASSWORD`: MySQL root password
- `NGINX_PORT`: Nginx listening port (default: 443)
- `SUBNET_IP`: Docker network subnet

## Project Structure
<!-- Directory and file organization -->
```
.
├── ansible.cfg           # Ansible configuration
├── group_vars/           # Group variables (encrypted)
├── init.sh               # Environment initialization script
├── inventory/            # Ansible inventory definitions
├── playbooks/            # Ansible playbooks
│   ├── deploy_site.yaml  # Main deployment playbook
│   └── teardown_site.yaml# Teardown playbook
├── requirements.txt      # Python dependencies
├── roles/                # Ansible roles
│   ├── down/             # Teardown role
│   ├── init/             # Initialization role
│   ├── mysql/            # MySQL role
│   ├── nginx/            # Nginx role
│   ├── phpmyadmin/       # phpMyAdmin role
│   ├── start/            # Start services role
│   └── wordpress/        # WordPress role
├── script.sh             # Deployment script
└── Vagrantfile           # Vagrant configuration
```

## Usage
<!-- Common usage examples -->
### Deploying the Site

```bash
./script.sh start
```

### Stopping the Site

```bash
./script.sh down
```

### Accessing the VM

```bash
vagrant ssh
```

### Modifying Configuration

1. Edit the vault file:

   ```bash
   ansible-vault edit group_vars/all.yaml
   ```
2. Redeploy the site:

   ```bash
   ./script.sh start
   ```

## Security Considerations
<!-- Security features and best practices -->
- All sensitive configuration is stored in Ansible vault files
- SSL certificates are automatically generated for HTTPS
- Containers run with minimal privileges
- Database passwords are randomly generated

## Troubleshooting
<!-- Common issues and their solutions -->
### Common Issues

1. **Vagrant machine fails to start**

   ```bash
   vagrant destroy
   vagrant up
   ```
2. **Ansible connection issues**

   ```bash
   # Regenerate SSH keys
   rm ~/.ssh/CloudOneKey*
   ./init.sh
   ```
3. **Docker containers not starting**

   ```bash
   # Check container logs
   vagrant ssh
   docker logs nginx
   docker logs wordpress
   docker logs mysql
   ```

## Contributing
<!-- Guidelines for project contributions -->
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License
<!-- Licensing information -->
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments
<!-- Credit to tools and technologies used -->
- [Ansible](https://www.ansible.com/)
- [Docker](https://www.docker.com/)
- [Vagrant](https://www.vagrantup.com/)
- [WordPress](https://wordpress.org/)
