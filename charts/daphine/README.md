```
# Daphine Helm Chart

Daphine is a Node.js Express API designed to stream music and videos. This Helm chart simplifies the deployment of Daphine on Kubernetes clusters.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+

## Installation

To install the chart with the release name `my-daphine`, run the following command:

```bash
helm install my-daphine /path/to/daphine/chart
```

This command deploys Daphine on the Kubernetes cluster with the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Parameters

The following table lists the configurable parameters of the Daphine chart and their default values.

| Parameter                                   | Description                                            | Default                          |
|---------------------------------------------|--------------------------------------------------------|----------------------------------|
| `frontend`                                  | Frontend URL required for CORS                         | `"https://example.com"`          |
| `nodeName`                                  | Preferred node to deploy the API                       | `""`                             |
| `replicaCount`                              | Number of API replicas to deploy                       | `1`                              |
| `image.repository`                          | Container image repository                             | `"ghcr.io/jordojordo/daphine"`   |
| `image.pullPolicy`                          | Image pull policy                                      | `"IfNotPresent"`                 |
| `image.tag`                                 | Image tag (defaults to the chart appVersion)           | `""`                             |
| `imagePullSecrets`                          | Specify image pull secrets                             | `[]`                             |
| `nameOverride`                              | Override the application name                          | `""`                             |
| `fullnameOverride`                          | Override the full application name                     | `""`                             |
| `serviceAccount.create`                     | Specifies whether a service account should be created  | `true`                           |
| `serviceAccount.automount`                  | Automount service account token                        | `true`                           |
| `serviceAccount.annotations`                | Annotations to add to the service account              | `{}`                             |
| `serviceAccount.name`                       | The name of the service account to use                 | `""`                             |
| `podAnnotations`                            | Annotations to add to each pod                         | `{}`                             |
| `podLabels`                                 | Additional labels to add to each pod                   | `{}`                             |
| `podSecurityContext`                        | Security contexts to set at the pod level              | `{}`                             |
| `securityContext`                           | Security settings for a pod                            | `{}`                             |
| `strategy`                                  | Deployment strategy                                    | `{}`                             |
| `service.type`                              | Kubernetes Service type                                | `"ClusterIP"`                    |
| `service.port`                              | Service port                                           | `3000`                           |
| `ingress.enabled`                           | Enable ingress controller                              | `false`                          |
| `ingress.className`                         | Ingress class name                                     | `""`                             |
| `ingress.hosts`                             | Hosts used by the ingress                              | `[{"host": "chart-example.local", "paths": [{"path": "/", "pathType": "ImplementationSpecific"}]}]` |
| `ingress.tls`                               | TLS settings for ingress                               | `[]`                             |
| `resources`                                 | CPU/Memory resource requests/limits                    | `{}`                             |
| `livenessProbe`                             | Liveness probe settings                                | `{httpGet: {path: "/health", port: "http"}}` |
| `readinessProbe`                            | Readiness probe settings                               | `{httpGet: {path: "/ready", port: "http"}}` |
| `autoscaling.enabled`                       | Whether horizontal pod autoscaling is enabled          | `false`                          |
| `autoscaling.minReplicas`                   | Minimum number of replicas                             | `1`                              |
| `autoscaling.maxReplicas`                   | Maximum number of replicas                             | `100`                            |
| `autoscaling.targetCPUUtilizationPercentage`| Target CPU utilization percentage                       | `80`                             |
| `nodeSelector`                              | Node labels for pod assignment                         | `{}`                             |
| `tolerations`                               | Tolerations for pod assignment                         | `[]`                             |
| `affinity`                                  | Affinity settings for pod assignment                   | `{}`                             |
| `storage.useExisting.pv`                    | Whether to use an existing PV                          | `false`                          |
| `storage.useExisting.pvc`                   | Whether to use an existing PVC                         | `false`                          |
| `storage.pv.type`                           | Type of persistent volume (local or NFS)               | `"local"`                        |
| `storage.pv.spec`                           | Specifications for persistent volume                    | `{}` (see values.yaml for details) |
| `storage.pvc.spec`                          | Specifications for PVC                                 | `{}` (see values.yaml for details) |

### Advanced Configuration

- **Persistent Volumes**: Specify whether to use existing PVs and PVCs by setting the respective `useExisting.pv` and `useExisting.pvc` parameters.
- **NFS Configuration**: If using NFS, provide the NFS server details and path in `values.yaml`.

### Custom Configuration Example

Override default values during installation like this:

```bash
helm install my-daphine /path/to/daphine/chart --set replicaCount=5, nodeName=some-other-node
```

### Service Configuration

The chart includes a `ClusterIP` service by default to expose the Node.js Express API. This can be customized by adjusting the `service.type` and `service.port` in `values.yaml`.

## Post-Installation Verification

After installation, verify the deployment with the following command:

```bash
kubectl get all -l "app.kubernetes.io/name=daphine"
```

## Upgrading

To upgrade the chart to a new version, use the following command:

```bash
helm upgrade my-daphine /path/to/daphine/chart
```

## Uninstallation

To uninstall/delete the `my-daphine` deployment:

```bash
helm delete my-daphine
```

This command removes all the Kubernetes components associated with the chart and deletes the release.

## Conclusion

Deploying Daphine using this Helm chart will provide you with a robust solution for streaming music and videos within your Kubernetes cluster. Ensure your environment is configured to handle network and storage resources as specified in `values.yaml`.
```
