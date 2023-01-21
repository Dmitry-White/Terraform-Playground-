module "web" {
  source = "../modules/web"
  environment = {
    name           = "qa"
    network_prefix = "10.0"
  }
}
