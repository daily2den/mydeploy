#!/usr/bin/env bash

git clone https://github.com/daily2den/mydeploy

## inits terraform
[ -d .terraform ] || terrform init

[ -d .ssh ] || mkdir .ssh
if [ ! -f .ssh/mydeploy ]; then

	## creates ssh key to use to access EC2 instance we 'll create
	ssh-keygen -b 2048 -t rsa -f .ssh/mydeploy -q -N ""

	## imports ssh key
	aws --profile mydeploy --region us-east-1 ec2 import-key-pair --key-name "mydeploy" --public-key-material file://.ssh/mydeploy.pub

fi

## creates aws objects (ec2 instance, etc)
terraform apply -var-file=mydeploy.tfvars
