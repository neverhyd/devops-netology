local p = import '../params.libsonnet';
local params = p.components.db;

[
 {
  apiVersion: 'v1',
  kind: 'PersistentVolumeClaim',
  metadata: {
   name: 'dbpvc',
  },
  spec: {
   storageClassName: "nfs",
   accessModes: ['ReadWriteOnce'],
   resources: {
     requests: {
      storage: '1Gi',
     },
   },
  },
 },
 {
  apiVersion: 'apps/v1',
  kind: 'StatefulSet',
  metadata: {
   name: 'db',
   labels: {
    app: 'db',
   },
  },
  spec: {
   replicas: params.replicas,
   serviceName: 'db',
   selector: {
    matchLabels: {
     app: 'db',
    },
   },
   template: {
    metadata: {
     labels: {
      app: 'db',
     },
    },
    spec: {
     containers: [
      {
       name: 'db',
       image: params.image,
       imagePullPolicy: 'IfNotPresent',
       volumeMounts: [
        {
         name: 'db-disk',
         mountPath: '/data',
        },
       ],
       env: [
        {
         name: 'POSTGRES_PASSWORD',
         value: 'testpassword',
        },
        {
         name: 'PGDATA',
         value: '/data/pgdata',
        },
       ],
      },
     ],
     volumes: [
      {
       name: 'db-disk',
       persistentVolumeClaim: {       
         claimName: 'dbpvc',
       },
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
   name: 'db-svc',
  },
  spec: {
   ports: [
    {
     port: 5432,
     targetPort: 5432,
     protocol: 'TCP',
    },
   ],
   selector: {
     app: 'db',
    },
   },
 },
]
