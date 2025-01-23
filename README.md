# apache_server
Automating the installation of the Apache server on an EC2 instance, provisioned with Terraform, and orchestrated via Jenkins using Ansible.

**NOTE**
 - Prefer using the Amazon Linux AMI, as it includes pre-installed software packages that simplify the setup process.
 -  Attach an IAM role with the ```AmazonEC2FullAccess``` policy to the EC2 instance control node.
 - Ensure you update the region, VPC ID, key name, and SSH inbound rule to allow with your IP address only.


**Ansible configuration file for dynamic inventory**
*/etc/ansible/ansible.cfg*

 ```bash
      [inventory]
      enable_plugins = aws_ec2

      [defaults]
      inventory=/home/ec2-user/apache_server/ansible/aws_ec2.yaml //replace with your inventory file path
      ansible_python_interpreter = /usr/bin/python3.9
      host_key_checking = False

      [ssh_connection]
      ssh_args = -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
 ```
