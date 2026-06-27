<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/7da36820-47ad-45f5-bda9-d92f3054de02" />


## AWS | EKS BluePrint ProxySQL
Provisioning an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform allows you to define your entire infrastructure (VPC, subnets, IAM roles, and the cluster itself) as code, ensuring repeatable, version-controlled, and automated deployments.



🎯 Architecture Overview
```
✅ VPC containing , Public+Private Subnets , NAT Gateway
✅ EKS Cluster Provisioner Workflow 
✅ Minio S3 Object Storage 
✅ Velero Disaster Recovery
✅ Velero UI Interface
✅ Local Exec ( Logical Workloads )
```


🧱 Features
```
✔ Fully automated provisioning with Terraform
✔ High availability using multiple subnets in different Availability Zones
✔ Secure connectivity between Application and RDS
✔ Configurable environment variables for database credentials
✔ Easy to extend for other JSON data source
```



🚀 Deployment Options
```
terraform init
terraform validate
terraform plan -var-file="template.tfvars"
terraform apply -var-file="template.tfvars" -auto-approve
```

