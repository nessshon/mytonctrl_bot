# mytonctrl_bot

## Installation via Script

1. Download and run the installation script:

   ```bash
   wget https://raw.githubusercontent.com/igroman787/mytonctrl_bot/master/install.sh
   chmod +x install.sh
   bash ./install.sh
   ```

   The script will create:

   * the project source directory: `/usr/src/mytonctrl_bot`;
   * the working directory: `/var/mytonctrl_bot`;
   * a systemd service named `mytonctrl_bot`.

2. Navigate to the project source directory:

   ```bash
   cd /usr/src/mytonctrl_bot
   ```

3. Configure the settings file:

   ```bash
   cp settings.json.example settings.json
   # edit settings.json
   ```

4. Start the service:

   ```bash
   sudo systemctl start mytonctrl_bot
   ```

---

## Installation via Docker

1. Install Docker and Docker Compose.

2. Clone the repository:

   ```bash
   git clone --recursive https://github.com/igroman787/mytonctrl_bot
   cd mytonctrl_bot
   ```

3. Configure the settings file:

   ```bash
   cp settings.json.example settings.json
   # edit settings.json
   ```

4. Start the container:

   ```bash
   docker compose up -d
   ```

   The `./data` directory on the host is mounted as the application’s working directory inside the container at `/usr/local/bin/mytonctrl_bot`.
