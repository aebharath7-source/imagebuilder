resource "aws_imagebuilder_image_recipe" "recipe" {
  name         = var.recipe_name
  version      = "1.0.0"
  parent_image = var.base_ami_id
  description  = "Image Recipe built from provided base AMI and existing component"

  component {
    component_arn = var.component_arn
  }

  tags = {
    ManagedBy = "terraform"
    Purpose   = "golden-ami"
  }
}
