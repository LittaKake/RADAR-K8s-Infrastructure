locals {
    # project_id = "radar"
    project_id = "cognite-experiments"
    name = "radar"
    location = "europe-west1"
    region = local.location
    environment = "dev"

    labels = {
        environment = local.environment
        team = "littakake"
    }
}