## Manifest for a simple two tire application: Wordpress and MySQL DB
- Create two namespaces: `wp` and `db`
- Deploy Wordpress manifests in `wp` directory under `wp` namespace
  - The file `combined.yaml` includes all the resouces and creates all resources using a single command: `kubectl apply -f combined.yaml -n wp`
- Deploy MySQL manifests in `db` directory under `db` namespace
  - The file `combined.yaml` includes all the resouces and creates all resources using a single command: `kubectl apply -f combined.yaml -n db`
