output "image_recipe_arn" {
  value       = aws_imagebuilder_image_recipe.recipe.arn
  description = "ARN of the created Image Recipe"
}

output "distribution_configuration_arn" {
  value       = aws_imagebuilder_distribution_configuration.dist.arn
  description = "ARN of the created Distribution Configuration"
}

output "image_pipeline_arn" {
  value       = aws_imagebuilder_image_pipeline.pipeline.arn
  description = "ARN of the created Image Pipeline"
}

output "infrastructure_configuration_arn_used" {
  value       = local.infra_arn
  description = "The Infrastructure Configuration ARN that the pipeline referenced (resolved from the input)"
}
