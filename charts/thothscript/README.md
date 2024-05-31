# ThothScript UI Helm Chart

This Helm chart is used to deploy the ThothScript UI on a Kubernetes cluster. The ThothScript UI provides an interface for interacting with the ThothScript operator to manage Kubernetes resources using natural language instructions.

## Installation

To install the chart with the release name `my-release`:

```sh
helm install my-release /path/to/thothscript-ui-chart
```

To install the chart with custom values:

```sh
helm install my-release /path/to/thothscript-ui-chart -f /path/to/custom-values.yaml
```

## Uninstallation

To uninstall the release:

```sh
helm uninstall my-release
```

## Parameters

The following table lists the configurable parameters of the ThothScript UI Helm chart and their default values.


| Parameter                              | Description                                    | Default                  |
|----------------------------------------|------------------------------------------------|--------------------------|
| `replicaCount`                         | Number of replicas of the UI deployment        | `1`                      |
| `image.repository`                     | Image repository                               | `nginx`                  |
| `image.tag`                            | Image tag                                      | `latest`                 |
| `image.pullPolicy`                     | Image pull policy                              | `IfNotPresent`           |
| `service.type`                         | Type of service                                | `ClusterIP`              |
| `service.port`                         | Port for the service                           | `80`                     |
| `ingress.enabled`                      | Enable ingress controller resource             | `false`                  |
| `ingress.annotations`                  | Annotations for the ingress                    | `{}`                     |
| `ingress.hosts`                        | Hostnames for the ingress                      | `[]`                     |
| `ingress.tls`                          | TLS configuration for the ingress              | `[]`                     |
| `resources`                            | Resource requests and limits                   | `{}`                     |
| `nodeSelector`                         | Node labels for pod assignment                 | `{}`                     |
| `tolerations`                          | Tolerations for pod assignment                 | `[]`                     |
| `affinity`                             | Affinity settings for pod assignment           | `{}`                     |
| `env.THOTHSCRIPT_PROXY_SCHEME`         | The scheme for the proxy                       | `ws`                     |
| `env.THOTHSCRIPT_PROXY_HOST`           | The host URL for the proxy                     | `localhost`              |
| `env.THOTHSCRIPT_PROXY_PORT`           | The port for the proxy                         | ``                     |
| `env.THOTHSCRIPT_PROXY_PATH`           | The path for the proxy                         | `/ws/`                   |
| `env.THOTHSCRIPT_OPERATOR_HOST`        | The host URL for the ThothScript operator      | `thothscript-operator`   |
| `env.THOTHSCRIPT_OPERATOR_NAMESPACE`   | The namespace for the ThothScript operator     | `thothscript`            |
| `env.THOTHSCRIPT_OPERATOR_PORT`        | The port for the ThothScript operator          | `3000`                   |


----


## Environment Variables

The following environment variables are used to configure the ThothScript UI and its proxying behavior:

- `THOTHSCRIPT_PROXY_HOST`: The host URL for the proxy. This is the address where the UI sends its requests. It should be set to the service address where the frontend is served from.
- `THOTHSCRIPT_PROXY_PORT`: The port for the proxy. This is the port where the UI sends its requests.
- `THOTHSCRIPT_OPERATOR_HOST`: The host URL for the ThothScript operator. This is the internal address of the operator within the cluster.
- `THOTHSCRIPT_OPERATOR_PORT`: The port for the ThothScript operator. This is the internal port of the operator within the cluster.

These environment variables are necessary because the UI is unable to utilize kube-dns. Therefore, the frontend WebSockets must be proxied in this way.

## Example values.yaml

Here is an example `values.yaml` file to help you get started with custom configurations:

```yaml
replicaCount: 2

image:
  repository: my-repo/thothscript-ui
  tag: v1.0.0
  pullPolicy: Always

service:
  type: LoadBalancer
  port: 8080

ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
  hosts:
    - host: thothscript.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: thothscript-tls
      hosts:
        - thothscript.example.com

resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi

env:
  THOTHSCRIPT_PROXY_HOST: "proxy.example.com"
  THOTHSCRIPT_PROXY_PORT: "8080"
  THOTHSCRIPT_OPERATOR_HOST: "operator.example.com"
  THOTHSCRIPT_OPERATOR_PORT: "3000"


Notes

- Ensure that the THOTHSCRIPT_PROXY_HOST and THOTHSCRIPT_PROXY_PORT environment variables are set correctly for the UI to send requests to the nginx container.
- The THOTHSCRIPT_OPERATOR_HOST and THOTHSCRIPT_OPERATOR_PORT should point to the ThothScript operator within the cluster.
- This configuration is necessary because the UI cannot use kube-dns, and the frontend WebSockets must be proxied through nginx.

For more detailed information, refer to the official Helm documentation: Helm.

You can customize this README.md further based on specific details or additional parameters you have in your Helm chart.