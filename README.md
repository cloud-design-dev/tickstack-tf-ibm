# tickstack-tf-ibm
Deploy a TickStack instance on the IBM Cloud using Terraform and Ansible

## Prerequisites
 - A domain hosted at [DNSimple](https://dnsimple.com). 
 - Terraform and Ansible installed locally.
 - The Public SSH key of the server you are running this example on. 
 - A Github Oauth Application for authentication with Chronograf. See [Chronograf Oauth docs](https://docs.influxdata.com/chronograf/v1.5/administration/managing-security/#creating-github-oauth-2-0-applications) for details on getting this set up. 

> Note: If you use a different DNS hosting service you can check the [Terraform Providers](https://www.terraform.io/docs/providers/index.html) to see if they are supported. You will need to update the `variables.tf`, `main.tf`, and `providers.tf` files accordingly.

## Initial Configuration
In order to properly configure the environment to run you will want to update the following values in `variables.tf`:

 - Replace `example.com` with the domain that you would like to use.

## Outline of steps
The deployment example will do the following

### Terraform
Terraform will be used to:
 - Spin up Infrastructure and create DNS record 
 - Generate custom Ansible Playbooks
 
### Ansible
Ansible will be used to:
 - Install Telegraf, InfluxDB, Kapacitor, and Chronograf
 
## Deploying TickStack using Terraform
### Grab example repo
Clone this example repo to your local system

```
git clone https://github.com/cloud-design-dev/tickstack-tf-ibm.git
tickstack-tf-ibm
```

You will also need to update the `install.yml` file to include your SSH-key. 

```
    ssh-authorized-keys:
    - 'ssh-rsa example-key'
```

### Configure credentials.tfvars file for authentication with IBM Cloud
Copy the example `credentials.tfvars.tpl` to `credentials.tfvars` and then update `credentials.tfvars` with the appropriate IBM Cloud, SL API, and Github Oauth information. 

```
cp credentials.tfvars.tpl credentials.tfvars
nano/vi credentials.tfvars
```

### Initialize Terraform** 
```
terraform init 
```

### Plan deployment and save to file**

```
terraform plan -var-file='./credentials.tfvars` -out tick.tfplan
```

### Apply deployment plan** 

```
terraform apply tick.tfplan
```

## Run Ansible Plabooks 

```
ansible-playbook -i Hosts/inventory.env Playbooks/deploy-environment.yml
```

## Next Steps

Visit `tickstack.your-domain.com:8888` to configure Chronograf. 

