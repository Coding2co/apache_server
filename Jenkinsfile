pipeline {
    agent any

    environment {
        ANSIBLE_DIR        = 'ansible'
        INVENTORY_PATH     = './aws_ec2.yaml'
        TERRAFORM_DIR      = 'terraform'
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Terraform') {
            steps {
                dir("${TERRAFORM_DIR}") {
                    echo "Running Terraform commands..."
                    sh 'terraform init'
                    sh 'terraform validate'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Ansible') {
            steps {
                dir("${ANSIBLE_DIR}") {
                    echo "Running Ansible Playbooks..."
                    sh 'ansible-inventory -i "${INVENTORY_PATH}" --graph'
                    echo "Installing Apache Server on EC2 Instance"
                    withCredentials([file(credentialsId: 'node_private_key', variable: 'PRIVATE_KEY_PATH')]) {
                        sh """
                            ansible-playbook -i "${INVENTORY_PATH}" playbook.yml \
                            --user ec2-user \
                            --private-key \$PRIVATE_KEY_PATH \
                            --limit target
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed with Error.'
        }
    }
}

