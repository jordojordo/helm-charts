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

| Parameter                          | Description                                         | Default                          |
|------------------------------------|-----------------------------------------------------|----------------------------------|
| `frontend`                         | Frontend URL required for CORS                      | `"https://example.com"`          |
| `nodeName`                         | Preferred node to deploy the API                    | `"local-node"`                   |
| `deployment.labels`                | Labels to apply to the Deployment                   | `{ yokanga.xyz/api: daphine }`   |
| `deployment.replicaCount`          | Number of API replicas to deploy                    | `3`                              |
| `deployment.image.repository`      | Container image repository                          | `"ghcr.io/jordojordo/daphine"`   |
| `deployment.image.pullPolicy`      | Image pull policy                                   | `"IfNotPresent"`                 |
| `deployment.image.tag`             | Image tag (defaults to app version)                 | `"0.2.0"`                        |
| `deployment.resources`             | CPU/Memory resource requests/limits                 | `{ limits: { cpu: 200m, memory: 100Mi }, requests: { cpu: 100m, memory: 50Mi } }` |
| `deployment.securityContext`       | Security context for the pod                        | `{ runAsNonRoot: true, runAsUser: 1001 }` |
| `deployment.strategy`              | Deployment strategy                                 | `{ type: RollingUpdate, rollingUpdate: { maxUnavailable: 1, maxSurge: 2 } }` |
| `service.type`                     | Kubernetes Service type                             | `"ClusterIP"`                    |
| `service.port`                     | Service port                                        | `3000`                           |
| `storage.pv.type`                  | Type of persistent volume (local or nfs)            | `"local"`                        |
| `storage.pv.local.*`               | Local volume settings (if `pv.type` is local)       | Detailed settings in `values.yaml` |
| `storage.pv.nfs.*`                 | NFS volume settings (if `pv.type` is nfs)           | Uncomment and configure in `values.yaml` |
| `storage.pvc.*`                    | Persistent Volume Claim settings                    | Detailed settings in `values.yaml` |
| `probes.livenessPath`              | Path for liveness probe                             | `"/health"`                      |
| `probes.readinessPath`             | Path for readiness probe                            | `"/ready"`                       |
| `probes.initialDelaySeconds`       | Initial delay before starting the probes            | `10`                             |
| `probes.periodSeconds`             | How often to perform the probe                      | `5`                              |

### Configuring NFS Storage

If you choose to use NFS instead of a local volume, you need to uncomment and configure the NFS-related settings in `values.yaml`. Specify the NFS server and path details accordingly.

### Custom Configuration Example

Override default values during installation like this:

```bash
helm install my-daphine /path/to/daphine/chart --set deployment.replicaCount=5, nodeName=some-other-node
```

## Post-Installation Verification

After installation, verify the deployment with the following command:

```bash
kubectl get all -l "yokanga.xyz/api=daphine"
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

After deployment, your Node.js API will be accessible within your cluster and ready to stream music and videos. Make sure to review your Kubernetes and Helm setup to ensure everything is configured correctly for network and storage access.
