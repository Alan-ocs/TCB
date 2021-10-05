resource "oci_load_balancer" "lb1" {
  shape          = "100Mbps"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.subnet1.id,
    oci_core_subnet.subnet2.id,
  ]

  display_name = "lb1"
  reserved_ips {
    id = "${oci_core_public_ip.test_reserved_ip.id}"
  }
}

resource "oci_load_balancer" "lb2" {
  shape          = "100Mbps"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.subnet1.id,
    oci_core_subnet.subnet2.id,
  ]

  display_name = "lb2"
}


variable "load_balancer_shape_details_maximum_bandwidth_in_mbps" {
  default = 100
}

variable "load_balancer_shape_details_minimum_bandwidth_in_mbps" {
  default = 10
}

resource "oci_load_balancer" "flex_lb" {
  shape          = "flexible"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.subnet1.id,
    oci_core_subnet.subnet2.id,
  ]

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = var.load_balancer_shape_details_maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.load_balancer_shape_details_minimum_bandwidth_in_mbps
  }

  display_name = "flex_lb"
}

resource "oci_load_balancer_backend_set" "lb-bes1" {
  name             = "lb-bes1"
  load_balancer_id = oci_load_balancer.lb1.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

resource "oci_load_balancer_backend_set" "lb-bes2" {
  name             = "lb-bes2"
  load_balancer_id = oci_load_balancer.lb2.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "TCP"
    response_body_regex = ".*"
    url_path            = "/"
  }

  # ssl_configuration {
  #   protocols         = ["TLSv1.1", "TLSv1.2"]
  #   cipher_suite_name = oci_load_balancer_ssl_cipher_suite.test_ssl_cipher_suite2.name
  #   certificate_name  = oci_load_balancer_certificate.lb-cert2.certificate_name
  # }
}

# resource "oci_load_balancer_certificate" "lb-cert1" {
#   load_balancer_id   = oci_load_balancer.lb1.id
#   ca_certificate     = var.ca_certificate
#   certificate_name   = "certificate1"
#   private_key        = var.private_key
#   public_certificate = var.public_certificate

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "oci_load_balancer_certificate" "lb-cert2" {
#   load_balancer_id   = oci_load_balancer.lb2.id
#   ca_certificate     = var.ca_certificate
#   certificate_name   = "certificate2"
#   private_key        = var.private_key
#   public_certificate = var.public_certificate

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "oci_load_balancer_path_route_set" "test_path_route_set" {
  #Required
  load_balancer_id = oci_load_balancer.lb1.id
  name             = "pr-set1"

  path_routes {
    #Required
    backend_set_name = oci_load_balancer_backend_set.lb-bes1.name
    path             = "/example/video/123"

    path_match_type {
      #Required
      match_type = "EXACT_MATCH"
    }
  }
}

resource "oci_load_balancer_hostname" "test_hostname1" {
  #Required
  hostname         = "app.example.com"
  load_balancer_id = oci_load_balancer.lb1.id
  name             = "hostname1"
}

resource "oci_load_balancer_hostname" "test_hostname2" {
  #Required
  hostname         = "app2.example.com"
  load_balancer_id = oci_load_balancer.lb1.id
  name             = "hostname2"
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = oci_load_balancer.lb1.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.lb-bes1.name
  hostname_names           = [oci_load_balancer_hostname.test_hostname1.name, oci_load_balancer_hostname.test_hostname2.name]
  port                     = 80
  protocol                 = "HTTP"
  rule_set_names           = [oci_load_balancer_rule_set.test_rule_set.name]

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_listener" "lb-listener2" {
  load_balancer_id         = oci_load_balancer.lb1.id
  name                     = "https"
  default_backend_set_name = oci_load_balancer_backend_set.lb-bes1.name
  port                     = 443
  protocol                 = "HTTP"

  # ssl_configuration {
  #   certificate_name        = oci_load_balancer_certificate.lb-cert1.certificate_name
  #   verify_peer_certificate = false
  #   protocols               = ["TLSv1.1", "TLSv1.2"]
  #   server_order_preference = "ENABLED"
  #   cipher_suite_name       = oci_load_balancer_ssl_cipher_suite.test_ssl_cipher_suite.name
  # }
}

resource "oci_load_balancer_listener" "lb-listener3" {
  load_balancer_id         = oci_load_balancer.lb2.id
  name                     = "tcp"
  default_backend_set_name = oci_load_balancer_backend_set.lb-bes2.name
  port                     = 80
  protocol                 = "TCP"

  connection_configuration {
    idle_timeout_in_seconds            = "2"
    backend_tcp_proxy_protocol_version = "1"
  }
}

resource "oci_load_balancer_backend" "lb-be1" {
  load_balancer_id = oci_load_balancer.lb1.id
  backendset_name  = oci_load_balancer_backend_set.lb-bes1.name
  ip_address       = oci_core_instance.instance1.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "lb-be2" {
  load_balancer_id = oci_load_balancer.lb2.id
  backendset_name  = oci_load_balancer_backend_set.lb-bes2.name
  ip_address       = oci_core_instance.instance2.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_rule_set" "test_rule_set" {
  items {
    action = "ADD_HTTP_REQUEST_HEADER"
    header = "example_header_name"
    value  = "example_header_value"
  }

  items {
    action          = "CONTROL_ACCESS_USING_HTTP_METHODS"
    allowed_methods = ["GET", "POST"]
    status_code     = "405"
  }

  items {
    action      = "ALLOW"
    description = "example vcn ACL"

    conditions {
      attribute_name  = "SOURCE_VCN_ID"
      attribute_value = oci_core_vcn.vcn1.id
    }

    conditions {
      attribute_name  = "SOURCE_VCN_IP_ADDRESS"
      attribute_value = "10.10.1.0/24"
    }
  }

  items {
    action = "REDIRECT"

    conditions {
      attribute_name  = "PATH"
      attribute_value = "/example"
      operator        = "FORCE_LONGEST_PREFIX_MATCH"
    }

    redirect_uri {
      protocol = "{protocol}"
      host     = "in{host}"
      port     = 8081
      path     = "{path}/video"
      query    = "?lang=en"
    }

    response_code = 302
  }

  items {
    action                         = "HTTP_HEADER"
    are_invalid_characters_allowed = true
    http_large_header_size_in_kb   = 8
  }

  load_balancer_id = oci_load_balancer.lb1.id
  name             = "example_rule_set_name"
}

output "lb_public_ip" {
  value = [oci_load_balancer.lb1.ip_address_details]
}

resource "oci_load_balancer_ssl_cipher_suite" "test_ssl_cipher_suite" {
  #Required
  name = "test_cipher_name"

  ciphers = ["AES128-SHA", "AES256-SHA"]

  #Optional
  load_balancer_id = oci_load_balancer.lb1.id
}

resource "oci_load_balancer_ssl_cipher_suite" "test_ssl_cipher_suite2" {
  #Required
  name = "test_cipher_name"

  ciphers = ["AES128-SHA", "AES256-SHA"]

  #Optional
  load_balancer_id = oci_load_balancer.lb2.id
}

data "oci_load_balancer_ssl_cipher_suites" "test_ssl_cipher_suites" {
  #Optional
  load_balancer_id = oci_load_balancer.lb1.id
}

data "oci_load_balancer_ssl_cipher_suites" "test_ssl_cipher_suites2" {
  #Optional
  load_balancer_id = oci_load_balancer.lb2.id
}