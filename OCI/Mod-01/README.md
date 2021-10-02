# The Cloud Bootcamp OCI Module 01
* ### Configuring OCI Cli

#### 1. Create your Private and Public keys:


```
openssl genrsa -out myPrivateKey.pem 2048
openssl rsa -pubout -in myPrivateKey.pem -out myPublicKey.pem
```

## DO NOT SHARE YOUR KEYS


#### 2. Import your Public Key on your OCI Identity Users console.


#### 3. Install the OCI Cli:
```
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```

#### 4. Configure the OCI Cli:

```
oci setup config
```

## You will need:
* Enter a location for your config:
* Enter a user OCID:
* Enter a tenancy OCID:
* Enter a region:
* Enter the location of your private key file:

#### 5. Test it:

```
oci iam availability-domain list
```

https://learncodeshare.net/2020/03/06/install-and-configure-the-oracle-cloud-command-line-interface/

https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.1.0/oci_cli_docs/


#### 6. Deploying the Lab with Terraform:

##### 1. Create a terraform.tfvars file with your info:

```
tenancy_ocid = "YOUR TENANCY OCID"

user_ocid = "YOUR USER OCID"

fingerprint = "YOUR FINGERPRINT"

private_key_path = "YOUR PRIVATE KEY PATH"

region = "YOUR REGION"
```

##### 2. Run the Terraform

```
terraform init
terraform validate
terraform plan
terraform apply
```


