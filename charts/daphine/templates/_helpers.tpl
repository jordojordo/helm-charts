{{/*
Expand the name of the chart.
*/}}
{{- define "daphine.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "daphine.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "daphine.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "daphine.labels" -}}
helm.sh/chart: {{ include "daphine.chart" . }}
{{ include "daphine.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "daphine.selectorLabels" -}}
app.kubernetes.io/name: {{ include "daphine.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "daphine.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "daphine.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define volume name.
*/}}
{{- define "daphine.volumeName" -}}
{{- if .Values.storage.useExisting.pv }}
{{- .Values.storage.useExisting.pvName }}
{{- else }}
{{- printf "%s-volume" (include "daphine.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Define PVC name.
*/}}
{{- define "daphine.pvcName" -}}
{{- if .Values.storage.useExisting.pvc }}
{{- .Values.storage.useExisting.pvcName }}
{{- else }}
{{- printf "%s-pvc" (include "daphine.fullname" .) }}
{{- end }}
{{- end }}

