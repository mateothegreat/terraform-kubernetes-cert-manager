resource "kubernetes_manifest" "cluster-issuer" {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "ClusterIssuer"

        metadata = {
            name = var.name
        }

        spec = {
            acme = {
                server = var.server
                email  = var.email

                privateKeySecretRef = {
                    name = "${ var.name }-cluster-issuer-staging"
                }
                solvers = [
                    {
                        http01 = {
                            ingress = {
                                class = "traefik"
                            }
                        }
                    }
                ]
            }
        }
    }
}
