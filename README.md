# Demo NFS Server on Digital Ocean managed by Terraform

    2019 Ondrej Sika <ondrej@ondrejsika.com>
    https://github.com/ondrejsika/terraform-demo-nfs

## Run NFS

```
terraform init
terraform plan
terraform apply -auto-approve
```

Server run on `nfs.sikademo.com`.


## Stop NFS

```
terraform destroy -auto-approve
```
