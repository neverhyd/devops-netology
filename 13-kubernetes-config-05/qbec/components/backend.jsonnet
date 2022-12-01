local p = import '../params.libsonnet';
local params = p.components.backend;

[
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'backend',
      labels: {
        app: 'backend',
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: 'backend',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'backend',
          },
        },
        spec: {
          containers: [
            {
              name: 'backend',
              image: params.image,
              imagePullPolicy: 'IfNotPresent',
              ports: [
                {
                 name: 'backport',
                 containerPort: 9000,
                 protocol: 'TCP',
                }
              ],
              env: [
                {
                 name: 'DATABASE_URL',
                 value: 'postgres://postgres:postgres@db-svc:5432/news',
                },
              ],
            },
          ],
        },
      },
    },
  },
 {
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
   name: 'backend-svc'
  },
  spec: {
   ports: [
    {
     port: 9000,
     targetPort: 9000,
     protocol: 'TCP',
    },
   ],
   selector: {
    app: 'backend'
   },
  },
 },
]
