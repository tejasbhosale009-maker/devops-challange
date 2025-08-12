{{- define "hello-world-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "hello-world-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" (include "hello-world-chart.name" .) .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

