resource "aws_imagebuilder_distribution_configuration" "dist" {
  name        = var.distribution_name
  description = "Distribution config - distributes AMI to us-east-1"

  distribution {
    region = "us-east-1"

    ami_distribution_configuration {
      name = var.ami_output_name

      # No launch_permission for now.
      # The AMI will be created and visible only in this account.
    }
  }

  tags = {
    ManagedBy = "terraform"
  }
}
