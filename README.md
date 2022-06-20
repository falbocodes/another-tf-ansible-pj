# another-tf-ansible-pj
## Yet another terraform ansible project!

another-tf-ansible-pj it's a little project started as a challenge. 
you will see how you can merge terraform and ansible for a better devops life.

# buzzwords are
- terraform
- ansible
- docker
- AutoMagic
- Azure DevOps

## Requirements
- terraform 0.14.3 
- ansible 2.12.6
- ansible-galaxy 2.12.6
- awscli 2.7.7

## Installation
# In the beginning was terraform...

Please rename vars.tf.example in vars.tf, and change to your liking, or create one that fits your will. 
```sh
mv vars.tf.example vars.tf
```
then 
```sh
terraform init
terraform plan
```
and wait for some devops magic to happen. 
At the end you will have: 
- aws vpc and subnet configurated
- two aws istances
- two ebs volume attached to the instances
- a key.pem that you can use for ssh connections

# Then was the ansible shift...

You have to install necessary requirements
```sh
ansible-galaxy install -r ansible/requirements.yml
```
configure ansible inventory, you could follow the example in 
```sh
ansible/inventory/hosts.example
```
then execute you could run 
```sh
ansible-playbook -i ansible/ ansible/playbook-base.yml
```
At the end you will have: 
- a shinny docker swarm cluster 

## Future improvements
- switching from ec2 instance to autoscaling group
- improve security 
- add molecule tests
- run ansible-play after having provisioned the instances
