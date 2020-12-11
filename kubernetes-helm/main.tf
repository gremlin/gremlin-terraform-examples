# Helm will require some information about your Kubernetes cluster in order to apply the chart.
# Your information will vary, but you will most likely receive the configuration information
# as an output resource following the Kubernetes cluster setup. In this example, that resource
# would be called "YOUR_K8S_CLUSTER".

provider "helm" {
  kubernetes {
    load_config_file       = "false"
    host                   = YOUR_K8S_CLUSTER.k8s_cluster.endpoint
    token                  = YOUR_K8S_CLUSTER.k8s_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(YOUR_K8S_CLUSTER.k8s_cluster.kube_config[0].cluster_ca_certificate)
  }
}


# Apply Gremlin Helm chart. For more information about the Helm install, see:
# https://www.gremlin.com/docs/infrastructure-layer/installation/#helm

resource "helm_release" "gremlin_helm_chart" {
  name  = "gremlin"
  chart = "gremlin/gremlin"

  set {
    name  = "gremlin.secret.managed"
    value = "true"
  }
  set {
    name  = "gremlin.secret.type"
    value = "secret"
  }
  set {
    name  = "gremlin.secret.clusterID"
    value = var.gremlin_cluster_id
  }
  set {
    name  = "gremlin.secret.teamID"
    value = var.gremlin_team_id
  }
  set {
    name  = "gremlin.secret.teamSecret"
    value = var.gremlin_team_secret
  }
}

