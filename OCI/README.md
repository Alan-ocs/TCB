# The Cloud Bootcamp OCI Module
* ### Configuring OCI Cli

#### 1. Create your Private and Public keys:


```
openssl genrsa -out myPrivateKey.pem 2048
openssl rsa -pubout -in myPrivateKey.pem -out myPublicKey.pem
```

#### 2.  Import the Public Key on your OCI Identity Users tab

## DO NOT SHARE YOUR KEYS

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