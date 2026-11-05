#!/usr/bin/env bash
# Install Nginx and configure the host firewall on an Ubuntu VM.
set -Eeuo pipefail

if [[ "$EUID" -ne 0 ]]; then
  echo "Run this script as root (for example: sudo bash scripts/setup-nginx.sh)." >&2
  exit 1
fi

ssh_allowed_cidr="${SSH_ALLOWED_CIDR:-}"
if [[ -z "$ssh_allowed_cidr" ]]; then
  echo "Set SSH_ALLOWED_CIDR to the authorized client IPv4 /32 before running this script." >&2
  exit 1
fi

echo "=== Updating package lists ==="
apt-get update

echo "=== Installing Nginx, curl, and UFW ==="
apt-get install -y nginx curl ufw

echo "=== Configuring the host firewall ==="
ufw default deny incoming
ufw default allow outgoing
ufw allow from "$ssh_allowed_cidr" to any port 22 proto tcp
ufw allow 80/tcp
ufw --force enable
ufw status verbose

echo "=== Publishing the Module 02 page ==="
host_name="$(hostname -s)"
os_name="$(. /etc/os-release && printf '%s' "$PRETTY_NAME")"
cat > /var/www/html/index.html <<HTML
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Module 02 — Linux &amp; Cloud Infrastructure</title>
</head>
<body>
  <h1>Module 02 — Linux &amp; Cloud Infrastructure</h1>
  <p>Host: $host_name</p>
  <p>OS: $os_name</p>
</body>
</html>
HTML
chown root:root /var/www/html/index.html
chmod 0644 /var/www/html/index.html

echo "=== Enabling and starting Nginx ==="
systemctl enable --now nginx
systemctl is-active --quiet nginx

echo "=== Checking the local HTTP response ==="
listeners=$(ss -ltnH 'sport = :80')
if ! grep -q '^LISTEN' <<< "$listeners"; then
  echo "Nginx is not listening on TCP port 80." >&2
  exit 1
fi
curl --fail --silent --show-error --output /dev/null --write-out 'HTTP %{http_code}\n' http://127.0.0.1/
echo "Nginx setup finished."
