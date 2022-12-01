local p = import '../params.libsonnet';
local params = p.components.namespace;

[
 {
  apiVersion: 'v1',
  kind: 'Namespace',
  metadata: {
   name: params.name,
  },
 }
]

