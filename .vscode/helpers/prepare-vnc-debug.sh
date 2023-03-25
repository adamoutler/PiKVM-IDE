grep -q '^#*AllowTcpForwarding\s+yes' /etc/ssh/sshd_config 
sed -i 's/^#*AllowTcpForwarding\s\+yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config
systemctl restart sshd.service