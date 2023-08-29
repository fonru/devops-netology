resource "yandex_mdb_mysql_cluster" "my-db-cluster" {
  name                = "MY_cluster"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.netology_vpc.id
  version             = "8.0"
  security_group_ids  = [ "enplb5dacrdl9g3nb1rk" ]
  deletion_protection = true

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = "20"
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.private_net.id
    priority = 10
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.private_net2.id
    priority = 20
  }

  backup_window_start {
    hours   = 23
    minutes = 59
  }

}

resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.my-db-cluster.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "db-user" {
  cluster_id = yandex_mdb_mysql_cluster.my-db-cluster.id
  name       = "mfonarev"
  password   = "12345678"
  permission {
    database_name = yandex_mdb_mysql_database.netology_db.name
    roles         = ["ALL"]
  }
}

