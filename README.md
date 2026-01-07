# EC2 Image Builder – Golden AMI Terraform Module

This Terraform module provisions AWS EC2 Image Builder resources for creating standardized Golden AMIs. It uses a user-provided base AMI, a pre-existing Image Builder component, and a pre-existing infrastructure configuration. The module creates the Image Recipe, Image Pipeline, and Distribution Configuration required to automate AMI creation.

This module does not create EC2 instances, components, or infrastructure configurations. It references resources that already exist in your AWS account.

---

## Architecture Overview

The following diagram illustrates the logical workflow of the AMI build process:

```
+-------------------------+
|   Base AMI (Input)      |
|  Provided by User       |
+------------+------------+
             |
             v
+-------------------------+
| Image Builder Component |
| (Existing in AWS)       |
+------------+------------+
             |
             v
+-------------------------+
| Image Recipe            |
| (Created by Module)     |
+------------+------------+
             |
             v
+-------------------------+
| Image Pipeline          |
| (Created by Module)     |
+------------+------------+
             |
             v
+-------------------------+
| Infrastructure Config   |
| (Existing in AWS)       |
+------------+------------+
             |
             v
+-------------------------+
|   Build Instance        |
| Launched by AWS         |
+------------+------------+
             |
             v
+-------------------------+
|  Golden AMI Output      |
| Distributed to Region   |
+-------------------------+
```

---

## Features

* Creates Image Builder recipes using a base AMI and an existing component
* Creates Image Builder pipelines for automated AMI builds
* Defines AMI distribution configuration for selected regions
* Supports custom naming for the recipe, pipeline, and distribution
* Requires no Organization ARN
* Supports AMI version templating

---

## Module Structure

The module manages the following AWS resources:

| AWS Resource                                | Description                   |
| ------------------------------------------- | ----------------------------- |
| aws_imagebuilder_image_recipe               | Defines the Golden AMI recipe |
| aws_imagebuilder_image_pipeline             | Controls AMI build execution  |
| aws_imagebuilder_distribution_configuration | Defines AMI distribution      |
| data.aws_imagebuilder_component             | Loads an existing component   |
| data.aws_ami                                | Resolves the base AMI         |

---

## Requirements

The following AWS resources must already exist and be provided as input:

1. Base AMI ID
2. Existing Image Builder Component ARN
3. Existing Infrastructure Configuration ARN

These resources must belong to the same region in which this module is deployed.

---

## Required Input Variables

| Variable Name                    | Type   | Description                                                   |
| -------------------------------- | ------ | ------------------------------------------------------------- |
| base_ami_id                      | string | AMI ID that serves as the starting point for the Golden AMI   |
| component_arn                    | string | ARN of an existing Image Builder component                    |
| infrastructure_configuration_arn | string | ARN of an existing Image Builder infrastructure configuration |
| image_recipe_name                | string | Name for the Image Recipe                                     |
| pipeline_name                    | string | Name for the Image Pipeline                                   |
| distribution_name                | string | Name for the Distribution Configuration                       |
| ami_output_name                  | string | Name template for the output AMI                              |

---

## Optional Input Variables

| Variable Name | Default Value | Description                  |
| ------------- | ------------- | ---------------------------- |
| region        | us-east-1     | AWS region for deployment    |
| version       | 1.0.0         | Version for the Image Recipe |

---

## Outputs

| Output Name                    | Description                           |
| ------------------------------ | ------------------------------------- |
| image_recipe_arn               | ARN of the created Image Recipe       |
| pipeline_arn                   | ARN of the created Image Pipeline     |
| distribution_configuration_arn | ARN of the distribution configuration |

---

## Example terraform.tfvars

region = "us-east-1"
base_ami_id = "ami-0abcdef1234567890"
component_arn = "arn:aws:imagebuilder:us-east-1:123456789012:component/my-component/1.0.0"
infrastructure_configuration_arn = "arn:aws:imagebuilder:us-east-1:123456789012:infrastructure-configuration/my-infra-config"

image_recipe_name = "company-golden-ami-recipe"
pipeline_name     = "company-golden-ami-pipeline"
distribution_name = "company-ami-distribution"
ami_output_name   = "company-golden-ami-{{imagebuilder:buildVersion}}"
version           = "1.0.0"

---

## Example Module Usage

module "image_builder" {
source = "./imagebuilder"

region                           = var.region
base_ami_id                      = var.base_ami_id
component_arn                    = var.component_arn
infrastructure_configuration_arn = var.infrastructure_configuration_arn

image_recipe_name = var.image_recipe_name
pipeline_name     = var.pipeline_name
distribution_name = var.distribution_name
ami_output_name   = var.ami_output_name
}

---

## Deployment Instructions

Step 1. Configure AWS credentials

aws configure

Step 2. Initialize Terraform

terraform init

Step 3. Review the execution plan

terraform plan -var-file="terraform.tfvars"

Step 4. Apply the configuration

terraform apply -var-file="terraform.tfvars"

After deployment, the Image Builder pipeline, recipe, and distribution configuration will be available in your AWS account.

---

## AMI Build Workflow

1. Terraform creates the Image Recipe, Distribution Configuration, and Image Pipeline.
2. AWS Image Builder launches a build instance when the pipeline is executed.
3. The component is applied to the base AMI.
4. A Golden AMI is generated and distributed to the specified region.
5. The resulting AMI appears under EC2 → AMIs.

Note: Image Builder pipelines do not execute automatically after creation. You must manually trigger a build using the AWS Console or AWS CLI:

aws imagebuilder start-image-pipeline-execution --image-pipeline-arn <pipeline_arn>

---

## Troubleshooting

Base AMI not found
Verify that the AMI ID exists in the same region specified for the module.

Component ARN invalid
Ensure the ARN belongs to your account, region, and matches the correct version.

Pipeline does not build automatically
Image Builder requires a manual initial execution unless scheduled.

---

## Notes

* The module does not require an Organization ARN.
* The module does not create infrastructure configurations or components but relies on existing resources.

Just tell me.
