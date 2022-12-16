# Avoiding copy paste in Terraform: Two approaches for multi-environment Infra as code setups


## Terraform workspaces vs symlinks and overrides

A typical discussion in current IT projects:

- A: We need to test something but we don’t want to break production
- B. Can’t you test it in the testing environment?
- A: We could but testing doesn’t have the same components deployed as prod. It’s not the same environment

This is constant tradeoff in software engineering. On the one hand, a testing environment needs to be exactly like production. On the other hand, production often contains lots of security constrictions that make it tedious to work in. So the “lower environments” get relaxed parameters which then skew the setup to be less realistic, making testing less helpful.

One way to reduce the disparity is to automate environment setup. If a single script call sets up the entire production environment, it is a lot easier to test in an “production-like” environment. However, terraform is brutally explicit, often requiring lots of copy/pasting. This is a design choice, but it often causes developers to duplicate entire folder structures across environments.

## Workspaces

Terraform offers a solution that can help avoid copying configuration across dev, test and prod. Workspaces allow switching between different copies of a single configuration and exposing the current workspace name as a value via terraform.workspace . This value can then be used to pass variables to modules based on the currently configured workspace. 
However, this is not an ideal solution. The [docs state](https://developer.hashicorp.com/terraform/language/state/workspaces) that workspaces are technically equivalent to renaming your state file. Hence, it really applies the exact same configuration to the different environments. Sure, this is exactly what we want right? Well, sure but the reality is, dev, tst and prod are different. CIDR blocks, hostnames etc often differ. This forces us to use the aforementioned workspace value to do hash map lookups to pass the right values to the right module based on the workspace. Such a solution is a convoluted approach and it makes the code less readable.

## Symbolic links and overrides

We propose another solution. Define the production environment and base our dev/test environments on production (through symbolic links), only overwriting the absolute necessities with explicit overrides. This way, all differences between prod and test are contained in a single *_override.tf file.

Sure, symbolic links are ugly. Ideally, terraform would offer an include statement but it doesnt. Symbolic links solve this, pulling a shared file into the environment of choice. Alternatively one may wrap terraform in a script that copies files into the target environment folder but we went for symlinks as everyone is on unix.

## The beauty of X_override.tf

Overriding specific variables in each environment with a infra_override.tf file. The benefit here is obvious. One file describes the discrepancy between test and prod. This both makes it very clear how the environments differ and it makes these differences “uncomfortable”, nudging us towards keeping the environments uniform.

The resulting folder structure is now:

```
.
├── deploy.sh
├── destroy.sh
├── dev
│   ├── infra_override.tf
│   ├── infra.tf -> ../universal/infra.tf
│   ├── output.tf -> ../universal/output.tf
│   ├── state.tf
│   ├── terraform.tfvars
│   └── variables.tf -> ../universal/variables.tf
├── prd
│   ├── infra.tf -> ../universal/infra.tf
│   ├── output.tf -> ../universal/output.tf
│   ├── state.tf
│   ├── terraform.tfvars
│   └── variables.tf -> ../universal/variables.tf
├── symlink.sh
├── tst
│   ├── infra_override.tf
│   ├── infra.tf -> ../universal/infra.tf
│   ├── output.tf -> ../universal/output.tf
│   ├── state.tf
│   ├── terraform.tfvars
│   └── variables.tf -> ../universal/variables.tf
└── universal
    ├── infra.tf
    ├── output.tf
    └── variables.tf
```

So what happens here? The three environments share the infra.tf, output.tf & variables.tf files. Running deploy.sh tst asks some reminder questions (such as “do you have all the credentials set up?”) and then executes our modules in the infra.tf file in a controlled order.

```
...terraform apply -target=module.account --auto-approve
terraform apply -target=module.infrastructure --auto-approve
...
terraform apply -target=module.infra-config-maps --auto-approve
```

In an ideal world, our terraform would simply be a terraform apply --auto-approve , however, when building very large terraform projects, dependencies between modules are sometimes hard to understand and calling the modules one at a time gives us greater control about the flow of deployment. It also allows manual steps in between if needed. A final terraform apply at the end should usually lead to 0 changes.

So what is actually different between prodand e.g. tst in our case? This:

```
module "infrastructure" {
	create_ecr_dkr_endpoint = false
	create_ecr_endpoint = false
}

module "kubernetes" {
	create_hosted_zone = true
}
```

Why? Well, in production, we get the hosted_zone provided by the central IT department. But in dev/tst, we just spin one up when we need it, managing that ourselves. The create_ecr_endpoint is set to false because our dev and tst environments are both hosted in the same VPC and therefore, we don’t require duplicate creation of these endpoints.

## Wrapping it up

Terraform is great for codifying infrastructure. When it comes to avoiding code replication and keeping Terraform code DRY, workspaces may work  for some, but usually they don't allow enough flexibility and make it convoluted to define different variables across environments. 

Through the [override functionality](https://developer.hashicorp.com/terraform/language/files/override), you now still define differences between dev and prod but it is very explicit. Whenever something is merged into the production environment, the development environment also receives that change unless it’s explicitly overwritten. This virtually removes any effort of “keeping development close to production”.