module "web_app_container" {
  source = "innovationnorway/web-app-container/azurerm"

  name = "tcbalansilvagestaorh2"

  resource_group_name = "gestaorh"

  container_type = "docker"

  container_image = "aocs/oci-projeto-final-cadastro-funcionarios-app:latest"
}
