1. terraform init

2. terraform plan -var-file="env/dev.terraform.tfvars" -var-file="client-configs/client1/client1-dev.json" -out tfplan

3. terraform apply tfplan