datapipeline-efs-backup-demo
============================

http://dev.classmethod.jp/cloud/aws/creating-efs-backup-environment-with-datapipeline-terraform-cloudformation/

```bash
$ ssh-keygen -f keys/key_pair -N ''
$ chmod 400 keys/key_pair
$ chmod 600 keys/key_pair.pub
$ cp -ipv secrets.sample.tfvars secrets.tfvars
$ sed -E -i '' 's/_YOUR_EMAIL_/hoge@example.com/' secrets.tfvars
$ terraform plan -var-file=secrets.tfvars
$ terraform apply -var-file=secrets.tfvars
```
