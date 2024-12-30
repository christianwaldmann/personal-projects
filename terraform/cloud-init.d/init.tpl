#cloud-config

# Packages updates are handled by packer
package_update: false
package_upgrade: false
package_reboot_if_required: false

# Lock down ssh
ssh_pwauth: false

runcmd:
  - systemctl restart sshd

write_files:
- path: /etc/profile
  append: true
  content: |
    cd /app
- path: /usr/local/bin/update-config
  permissions: '0755'
  encoding: b64
  content: ${base64encode(update_config_script)}

output:
  all: '| tee -a /var/log/cloud-init-output.log'
