aws_region = "us-east-1"

base_ami_id = "ami-002d4541ab96501c9"

component_arn = "arn:aws:imagebuilder:us-east-1:268200823035:component/my-component/1.0.0/1"

# You can supply either the ARN OR the NAME of your existing infra config:
# e.g. ARN:
infrastructure_configuration_identifier = "arn:aws:imagebuilder:us-east-1:268200823035:infrastructure-configuration/my-infra-config"
# or e.g. NAME:
# infrastructure_configuration_identifier = "my-infra-config"

organization_arn = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

pipeline_name     = "company-golden-ami-pipeline"
recipe_name       = "company-golden-ami-recipe"
distribution_name = "company-golden-distribution"

ami_output_name = "company-golden-ami-{{imagebuilder:buildDate}}-{{imagebuilder:buildVersion}}"
