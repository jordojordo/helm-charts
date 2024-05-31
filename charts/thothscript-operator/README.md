# ThothScript Operator Helm Chart

## Overview

The ThothScript Operator Helm chart is designed to facilitate the deployment of the [ThothScript Operator](https://github.com/jordojordo/thothscript-operator) in a Kubernetes cluster. The operator enables script operations on the cluster using the GPTScript AI, providing an API interface that leverages kubectl and Helm capabilities to manage Kubernetes resources through natural language scripting.

## Installation

To install the ThothScript Operator Helm chart, follow these steps:

1. Add the Helm repository (if not already added) and update:

```bash
helm repo add jordojordo https://jordojordo.github.io/helm-charts
helm repo update
```

2. Install the ThothScript Operator chart:

```bash
helm install thothscript-operator jordojordo/thothscript-operator
```

## Parameters

The parameters in the `values.yaml` file allow you to customize the deployment of the ThothScript Operator. Here is a description of each parameter:

| Parameter                           | Description                                                           | Default                                     |
|-------------------------------------|-----------------------------------------------------------------------|---------------------------------------------|
| `namespace`                         | Namespace where the ThothScript Operator will be deployed             | `thothscript`                               |
| `replicaCount`                      | Number of replicas of the ThothScript Operator                        | `1`                                         |
| `image.repository`                  | Docker image repository for the ThothScript Operator                  | `ghcr.io/jordojordo/thothscript-operator`   |
| `image.tag`                         | Docker image tag for the ThothScript Operator                         | `"0.1.0"`                                   |
| `image.pullPolicy`                  | Image pull policy                                                     | `"Always"`                                  |
| `service.type`                      | Type of Kubernetes service (e.g., ClusterIP, NodePort, LoadBalancer)  | `"ClusterIP"`                               |
| `service.port`                      | Port for the Kubernetes service                                       | `3000`                                      |
| `service.nodePort`                  | NodePort for the Kubernetes service (if type is NodePort)             | `null`                                      |
| `resources.requests.memory`         | Memory request for the ThothScript Operator pods                      | `nil`                                       |
| `resources.requests.cpu`            | CPU request for the ThothScript Operator pods                         | `nil`                                       |
| `resources.limits.memory`           | Memory limit for the ThothScript Operator pods                        | `nil`                                       |
| `resources.limits.cpu`              | CPU limit for the ThothScript Operator pods                           | `nil`                                       |
| `nodeSelector`                      | Node selector for pod assignment                                      | `{}`                                        |
| `tolerations`                       | Tolerations for pod assignment                                        | `[]`                                        |
| `affinity`                          | Affinity rules for pod assignment                                     | `{}`                                        |
| `rbac.role.resources`               | Resources managed by the Role                                         | `[{"name": "pods", "apiGroup": ""}, {"name": "deployments", "apiGroup": "apps"}]`  |
| `rbac.role.verbs`                   | Verbs allowed for the Role                                            | `["get", "watch", "list", "create", "update", "patch", "delete"]` |
| `rbac.clusterRole.resources`        | Resources managed by the ClusterRole                                  | `[{"name": "namespaces", "apiGroup": ""}]`  |
| `rbac.clusterRole.verbs`            | Verbs allowed for the ClusterRole                                     | `["get", "list", "watch", "create", "update", "delete"]` |
| `serviceAccount.create`             | Create a service account                                              | `true`                                      |
| `serviceAccount.name`               | Name of the service account                                           | `thothscript-operator`                      |
| `env.OPENAI_API_KEY_NAME`           | Secret name for OpenAI API key                                        | `openai-api-key`                            |
| `env.OPENAI_API_KEY`                | OpenAI API Key                                                        | `"<your-base64-encoded-api-key>"`           |

Example values.yaml:

```yaml
replicaCount: 1

image:
  repository: your-docker-repo/thothscript-operator
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

resources:
  requests:
    memory: "64Mi"
    cpu: "250m"
  limits:
    memory: "128Mi"
    cpu: "500m"

nodeSelector: {}

tolerations: []

affinity: {}

websocket:
  port: 3000
  secure: false

rbac:
  create: true

serviceAccount:
  create: true
  name: thothscript-operator

ingress:
  enabled: false
  annotations: {}
  hosts:
    - host: chart-example.local
      paths: []
  tls: []
```

## RBAC Configuration

The ThothScript Operator requires specific roles and cluster roles to manage Kubernetes resources. The roles and cluster roles allow the operator to perform CRUD operations on the given types of resources.

### ClusterRole

The ClusterRole defines the permissions required for the ThothScript Operator to manage resources cluster-wide. Here is an example of a ClusterRole:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: thothscript-operator-clusterrole
rules:
  - apiGroups: [""]
    resources: ["pods", "services", "endpoints"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["apps"]
    resources: ["deployments", "statefulsets"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["batch"]
    resources: ["jobs", "cronjobs"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["extensions"]
    resources: ["ingresses"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```

### Role

The Role defines the permissions required for the ThothScript Operator to manage resources within a specific namespace. Here is an example of a Role:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: thothscript-operator-role
  namespace: your-namespace
rules:
  - apiGroups: [""]
    resources: ["pods", "services", "configmaps"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
  - apiGroups: ["apps"]
    resources: ["deployments", "replicasets"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```

## Usage

Once the ThothScript Operator is deployed, you can interact with it via its WebSocket API to send GPTScript commands and manage Kubernetes resources through natural language scripting.

For more details on how to use the ThothScript Operator, refer to the main README file of the [ThothScript Operator project](https://github.com/jordojordo/thothscript-operator).