resource "null_resource" "weaviate_ready" {
  
  provisioner "local-exec" {
    command = <<EOT
      echo "Waiting for httpd to be ready..."

      for i in $(seq 1 30); do
        # Use the correct in-cluster service DNS
        if kubectl run curl-test --rm -i --restart=Never \
          --image=yauritux/busybox-curl:latest \
          -- sh -c "curl -s http://httpd-server.default.svc.cluster.local:80"; then
          echo "✅ httpd is ready!"
          exit 0
        fi
        echo "⏳ Still waiting..."
        sleep 5
      done

      echo "Timeout waiting for httpd server"
      exit 1
    EOT
  }
}
