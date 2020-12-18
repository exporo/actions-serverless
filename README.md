Use the Serverless commands in your Github Actions.
============================================

Serverless Framework is a tool that allows Easy YAML + CLI development and deployment to AWS, Azure, Google Cloud, Knative & more.

This Github Action make it simpler to run *serverless* commands with Convention over configuration and DRY paradigms.


Usage
-----

Create your Github Workflow configuration in `.github/workflows/ci.yml` or similar.

```yaml
name: CI

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    ...
    - uses: exporo/actions-serverless@v1
      with:
        # action parameters
    ...
```

Available action parameters
-----------------------

Adding `- uses: exporo/actions-serverless@v1` into your workflow will fail without additional parameters declared, as they are required for perform action properly.
You have to set all required parameters that offer no default value. For those who do so, the default one will be
used if you don't pass parameter in your step declaration.

List of all available parameters

|name                   |is required   	| default value                 | description                                   |   	
|---	                |---	        |---	                        |---	                                        |
| command  	            | yes           |   	                        | Serverless command to be executed  	        |
| stage 	            | yes 	        |   	                        | Deployment stage  	                        |
| aws-profile  	        | no  	        | default  	                    | Serverless profile name  	                    |
| aws-region  	        | no  	        | eu-central-1                  | Region where deployment will happen  	        |
| directory 	        | no  	        | . (current)                   | Directory containing *serverless.yml* file  	|
| aws-access-key-id 	| no  	        | AWS_ACCESS_KEY_ID (secret)    | See *Secrets* section  	                    |
| aws-secret-access-key | no  	        | AWS_SECRET_ACCESS_KEY (secret)| See *Secrets* section 	                    |


Secrets
-------------------------------------------
In order to use the action, you have to setup AWS keys for [Programmatic access][programatic-access]
under Github Secrets section in your repository settings.
`AWS_ACCESS_KEY_ID` – ex. `AKIAIOSFODNN7EXAMPLE`

`AWS_SECRET_ACCESS_KEY` – ex. `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY`

If you have no possibility to store keys under required names, you still can pass them
as action arguments.

How it works
-------------------------------------------
Behind the scenes the action stores provided credentials (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) 
under named section in `~/.aws/credentials` and region under `~/.aws/config`

Finally, it runs `serverless` command with provided arguments:

```shell script
serverless [command] --stage [stage] --aws-profile [aws-profile]
```

The action container itself is based on [exporo/sls-docker-image](https://github.com/exporo/sls-docker-image),
build on top of *alpine*, with serverless addons preinstalled.

Example commands that can be run with the action
--------------------------------------

##### Deployment
```yaml
...
  - name: Deploy
    uses: exporo/actions-serverless@master
    with:
      command: deploy
      stage: dev
      aws-profile: example-profile
```

Deployment with custom directory
```yaml
...
  - name: Deploy
    uses: exporo/actions-serverless@master
    with:
      command: deploy
      stage: dev
      aws-profile: example-profile
      aws-region: eu-central-1
      directory: ./application
```


Deployment with different region
```yaml
...
  - name: Deploy
    uses: exporo/actions-serverless@master
    with:
      command: deploy
      stage: dev
      aws-profile: example-profile
      aws-region: us-west-1
```

##### Create Certificate
```yaml
...
  - name: Create Certificate
    uses: exporo/actions-serverless@master
    with:
      command: create-cert
      stage: dev
      aws-profile: example-profile
      aws-region: eu-central-1
```

##### Create Domain
```yaml
...
  - name: Create Domain
    uses: exporo/actions-serverless@master
    with:
      command: create_domain
      stage: dev
      aws-profile: example-profile
      aws-region: eu-central-1
```

##### Create Domain
```yaml
...
  - name: Remove Stack
    uses: exporo/actions-serverless@master
    with:
      command: remove
      stage: dev
      aws-profile: example-profile
      aws-region: eu-central-1
```


[programatic-access]: https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys
