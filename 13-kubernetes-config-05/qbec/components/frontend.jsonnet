local p = import '../params.libsonnet';
local params = p.components.frontend;

[
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'frontend',
      labels: {
        app: 'frontend',
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: 'frontend',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'frontend',
          },
        },
        spec: {
          containers: [
            {
              name: 'frontend',
              image: params.image,
              imagePullPolicy: params.imagePullPolicy,
              ports: [
                {
                 name: 'frontport',
                 containerPort: params.containerPort,
                 protocol: 'TCP',
                }
              ],
              env: [
                {
                 name: 'BASE_URL',
                 value: 'http://backend-svc:9000',
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
   name: 'frontend-svc'
  },
  spec: {
   ports: [
    {
     port: params.containerPort,
     targetPort: params.containerPort,
     protocol: 'TCP',
    },
   ],
   selector: {
    app: 'frontend'
   },
  },
 },
]
