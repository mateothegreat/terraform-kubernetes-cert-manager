provider "kubernetes" {
    config_path = "~/Downloads/civo-nvrai-dev-kubeconfig"
}

module "test" {
    source    = "../"
    name      = "test"
    namespace = "default"
    email     = "matthew@matthewdavis.io"
}


resource "kubernetes_manifest" "traefik-router" {
    manifest = {
        apiVersion = "traefik.containo.us/v1alpha1"
        kind       = "IngressRoute"

        metadata = {
            name      = "test"
            namespace = "frontends"
        }
        
        spec = {
            entryPoints = [
                "https"
            ]
            routes = [
                {
                    kind  = "Rule"
                    match = "Host(`test-1.dev.nvr.ai`) && PathPrefix(`/`)"

                    services = [
                        {
                            name      = "frontend-app"
                            namespace = "frontends"
                            port      = 8080
                        }
                    ]
                }
            ]
            tls = {
                secretName = "test"
            }
        }
    }
}

resource "kubernetes_manifest" "cluster-issuer" {
    manifest = {
        apiVersion = "cert-manager.io/v1"
        kind       = "Certificate"

        metadata = {
            namespace = "default"
            name      = "test"
        }

        spec = {
            secretName = "test"
            dnsNames   = [
                "test-1.dev.nvr.ai",
            ]
            issuerRef = {
                name = "test"
                kind = "ClusterIssuer"
            }
        }
    }
}
