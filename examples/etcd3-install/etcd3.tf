// Create an etcd3 profile
resource "matchbox_profile" "etcd3" {
  name = "etcd3"
  config = "${matchbox_config.etcd3.name}"
}

// Create etcd3 CoreOS config resource
resource "matchbox_config" "etcd3" {
  name = "etcd3.yaml.tmpl"
  contents = "${file("./etcd3.yaml.tmpl")}"
}

// Create matchers for 3 nodes

resource "matchbox_group" "node1" {
  name = "node1"
  profile = "${matchbox_profile.etcd3.name}"
  selector {
    mac = "52:54:00:a1:9c:ae"
    os = "installed"
  }
  metadata {
    domain_name = "node1.example.com"
    etcd_name = "node1"
    etcd_initial_cluster = "node1=http://node1.example.com:2380,node2=http://node2.example.com:2380,node3=http://node3.example.com:2380"
  }
}

resource "matchbox_group" "node2" {
  name = "node2"
  profile = "${matchbox_profile.etcd3.name}"
  selector {
    mac = "52:54:00:a1:9c:ae"
    os = "installed"
  }
  metadata {
    domain_name = "node2.example.com"
    etcd_name = "node2"
    etcd_initial_cluster = "node1=http://node1.example.com:2380,node2=http://node2.example.com:2380,node3=http://node3.example.com:2380"
  }
}

resource "matchbox_group" "node3" {
  name = "node3"
  profile = "${matchbox_profile.etcd3.name}"
  selector {
    mac = "52:54:00:a1:9c:ae"
    os = "installed"
  }
  metadata {
    domain_name = "node3.example.com"
    etcd_name = "node3"
    etcd_initial_cluster = "node1=http://node1.example.com:2380,node2=http://node2.example.com:2380,node3=http://node3.example.com:2380"
  }
}
