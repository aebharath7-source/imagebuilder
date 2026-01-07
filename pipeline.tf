resource "aws_imagebuilder_image_pipeline" "pipeline" {
  name        = var.pipeline_name
  description = "Image Pipeline created by Terraform using provided infra config and recipe."

  image_recipe_arn = aws_imagebuilder_image_recipe.recipe.arn

  infrastructure_configuration_arn = local.infra_arn

  distribution_configuration_arn = aws_imagebuilder_distribution_configuration.dist.arn

  # default settings -- no schedule. Add schedule block if you want automated builds.
  tags = {
    ManagedBy = "terraform"
  }
}
