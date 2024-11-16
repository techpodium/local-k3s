
## Managing Secrets in Helm Charts
- Install helm secret plugin
```
helm plugin install https://github.com/jkroepke/helm-secrets --version v4.5.1
```

- If you want to install lates version:
```
helm plugin install https://github.com/jkroepke/helm-secrets
```

- Creates `.sops.yaml` for your charts
```
creation_rules:
  - gcp_kms: projects/<project-id>/locations/<gcp-region>/keyRings/<key-ring-name>/cryptoKeys/<key-name>
    # Specify any file patterns you want to auto-encrypt
    path_regex: '.*\.yaml$'
    encrypted_regex: '^(secrets)$'
```

- Encrypt the secrets.yaml using sops:
`sops -e dev/secrets.dec.yaml > dev/secrets.yaml`

- Use helm command to deploy the charts:
`helm secrets install wordpress-db -n wpdb . -f dev/values.yaml -f dev/secrets.yaml`

- **Important** Makesure you include `*.dec.yaml` into your `.gitignore` file to avoid accidental commit
