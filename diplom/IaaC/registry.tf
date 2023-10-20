resource "yandex_container_registry" "diplom-registry" {
  name = local.registry_name
  folder_id = local.folder_id
}

resource "yandex_container_registry_ip_permission" "diplom-registry_permission" {
  registry_id = yandex_container_registry.diplom-registry.id
  push        = local.registry_push_ip
  pull        = local.registry_pull_ip
}