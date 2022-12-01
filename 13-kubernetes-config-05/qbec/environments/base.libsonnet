
// this file has the baseline default parameters
{
  components: {
    db: {
      replicas: 1,
      image: "postgres:13-alpine",
    },
    backend: {
      replicas: 1,
      image: "olegananyev/kub-dz-backend:1",
    },
    frontend: {
      replicas: 1,
      image: "neverhyd/frontend",
      imagePullPolicy: 'IfNotPresent',
      containerPort: 80,
    },
  },
}
