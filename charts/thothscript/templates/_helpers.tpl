{{- define "thothscript.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "thothscript.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Define namespace name
*/}}
{{- define "thothscript.namespace" -}}
{{ default .Release.Namespace .Values.namespace | quote }}
{{- end }}

{{- define "thothscript.labels" -}}
helm.sh/chart: {{ include "thothscript.chart" . }}
{{ include "thothscript.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "thothscript.selectorLabels" -}}
app.kubernetes.io/name: {{ include "thothscript.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "thothscript.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}
