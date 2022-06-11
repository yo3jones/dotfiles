require ('plugins')
require ('settings')
require ('mappings')
require ('lsp')
{{- if .ForTag "work" }}
require('local-work')
{{ else }}
require('local')
{{- end -}}
