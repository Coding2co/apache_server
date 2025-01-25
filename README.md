# apache_server
This repository automates the setup of an Apache server on an EC2 instance using **Terraform**, **Ansible**, and **Jenkins** for continuous integration. The EC2 instance is provisioned on AWS, and Apache is installed and configured through an Ansible playbook. This project uses **dynamic inventory** with Ansible to automatically discover EC2 instances created by Terraform.

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

# Required Tools

Make sure the following tools are installed:

1. **Python**: Needed for Ansible dynamic inventory to make interactions with AWS.
2. **Pip**: Python package manager to install libraries.
3. **Boto3**: AWS SDK for Python to manage AWS resources.
4. **Botocore**: Supports Boto3 for AWS service access.
5. **Ansible**: Automation tool for configuring and managing servers.
6. **Terraform**: Tool for provisioning cloud resources (like EC2) on AWS.
7. **Jenkins**: Automation server for CI/CD pipelines.
8. **Java**: Required to run Jenkins.
9. **Git**: Version control for managing code and integrations.

