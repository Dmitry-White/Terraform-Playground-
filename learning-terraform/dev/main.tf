module "web" {
  source = "../modules/web"
  environment = {
    name           = "dev"
    network_prefix = "10.0"
  }
}
