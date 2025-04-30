1. terraform init

2. terraform plan -var-file="env/dev.terraform.tfvars" -var="resource_yaml_path=/Users/sasidarendinakaran/Documents/Lumen/Internals/Automation/github_actions_test/cc-client-config-repo/client1/azure/dev/resources.yaml" -out tfplan

3. terraform apply tfplan