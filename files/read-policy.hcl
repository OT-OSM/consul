# Allow DNS to find nodes and services
node_prefix "" {
  policy = "read"
}

service_prefix "" {
  policy = "write"
}
