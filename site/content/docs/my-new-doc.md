+++
title = "Lets Terraform my way"
description = "In this document I capture Terraform practices, I have discovered over the years"
date = 2018-03-08T05:03:02Z
weight = 20
draft = false
bref = ""
toc = true
+++

# Terraform

We will use the modular approach to keep our Terraform code generic ( repeatable) with as little rework as possible.

We will discuss the below tree structure

```
├── README.md
├── aws_instance
├── instance.tf
├── provider.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── vars.tf

```
## Variables:

We will use **variables** to **hide secrets**.

### How to declare variables ?

* We will create a file called **vars.tf** and in vars.tf we are going to declare our variables.
* Variables are declared by using the keywork **variable** followed by `<variable-name>` followed by curly braces`{}`.

	**Example:**

	`variable "variable-name" {}`

* We can define **default values** for our variables using the keywork **default**.
* If curly braces {} are empty we are not defining any values.

**Example:** Below example shows a vars.tf file.

vars.tf

	variable "AWS_ACCESS_KEY" {}
	variable "AWS_SECRET_KEY" {}
	variable "AWS_REGION" {
	  default = "ap-southeast-2"
	}
	variable "AMIS" {
	  type = "map"
	  default = {
	    ap-southeast-2 = "ami-10ca2172"
	  }
	}


### How to access Variables ?

In Terraform variables are accessed by the following syntax `"${var.XXXX}"`.

**Example:** We can access the variable `AWS_SECRET_KEY` defined above  
	             as shown in the example below.

	`access_key = "{var.AWS_SECRET_KEY}"`

### How to keep variables out of source control ?

  We will create a file called **Terraform.tfvars** and we will store the values of our variables in this file and keep it out of source control.We will do this, by defining it in our **git.ignore** file


 **Example:** A **terraform.tfvars** file definition shown below.

 Terraform.tfvars

	AWS_ACCESS_KEY = ""
	AWS_SECRET_KEY = ""
	AWS_REGION = ""


   **Example:** Below an example of defining the provider configuration.

   provider.tf


     provider "aws" {
      access_key = "${var.AWS_ACCESS_KEY}"
      secret_key = "${var.AWS_SECRET_KEY}"
      region = "${var.AWS_REGION}"
     }

   **Example:** Below an example of defining the instance configuration.


   instance.tf


    resource "aws_instance" "example" {
    ami = "ami-897897"
    instance_type = "t2.micro"
    }

   **Example:** Below another example of defining the instance configuration.


    resource "aws_instance" "example" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    }
