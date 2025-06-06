#cloud-config

# Packages updates are handled by packer
package_update: false
package_upgrade: false
package_reboot_if_required: false

# Lock down ssh
ssh_pwauth: false

# Don't use runcmd, because otherwise automounting the volume won't work anymore, see:
# https://github.com/hetznercloud/terraform-provider-hcloud/issues/473

write_files:
- path: /etc/profile
  append: true
  content: |
    cd /app
- path: /usr/local/bin/update-config
  permissions: '0755'
  encoding: b64
  content: ${base64encode(update_config_script)}
- path: /root/.ssh/storagebox
  permissions: '0600'
  encoding: b64
  content: |
    ${storagebox_ssh_private_key}
- path: /usr/local/bin/backup
  permissions: '0755'
  encoding: b64
  content: ${base64encode(backup_script)}

output:
  all: '| tee -a /var/log/cloud-init-output.log'
