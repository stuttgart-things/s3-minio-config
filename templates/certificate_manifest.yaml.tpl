%{ for INGRESS_HOSTNAME in split(",", INGRESS_HOSTNAME) }
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name:  ${NAME}-${INGRESS_HOSTNAME}
  namespace: ${NAMESPACE}
spec:
  commonName: ${INGRESS_HOSTNAME}.${INGRESS_DOMAIN}
  dnsNames:
    - ${INGRESS_HOSTNAME}.${INGRESS_DOMAIN}
  issuerRef:
    kind: ClusterIssuer
    name: ${CLUSTER_ISSUER}
  secretName: ${INGRESS_HOSTNAME}-ingress-tls
  %{ endfor }
