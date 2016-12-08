# Simple sample Cloudify blueprints

This repository contains collection of simple, minimalistic blueprints that
demonstrate various Cloudify related concepts with small, but fully functional
examples.

The only requirement for these blueprints is a working Cloudify Manager.
Blueprints are written in such a way that they do not require any additional
infrastructure, so your Cloudify Manager can safely run inside a virtual
machine on your laptop.


# Quick-start

Blueprints in this repo serves as a reference that should be read before being
deployed. Bonus points if people try to predict the log output of the scripts
in advance. But just in case, here are some quick instructions on how to
deploy them.


## Getting this repository

In order to obtain this repository, simply execute:

    cd ~
    git clone <url> cloudify-mini-examples

And this is all there is to do. You can also download this repository and
unzip it manually, but you probably know how to do this.


## Prerequisites

We will assume that Cloudify Manager is available to us at 10.11.12.13 and
that is password protected with username `admin`and password `pass`.

Now we need to install Cloudify client. In order not to pollute our system, we
will install it inside virtual environment. Steps that we need to take are:

    cd ~/cloudify-mini-examples
    virtualenv -p python2 venv
    . venv/bin/activate
    pip install cloudify==3.4

Next, we need to do export some environment variables that `cfy` command will
use:

    export CLOUDIFY_USERNAME=admin
    export CLOUDIFY_PASSWORD=pass

If your Cloudify Manager is not password protected, you do not need to do
anything here.

After this is done, we need to initialize cloudify client and point it to our
manager.  Again, a few simple commands is all we need:

    cfy init
    cfy use -t 10.11.12.13

To check if everything is properly configures, execute

    cfy status

This command should print something like this:

    Retrieving manager services status... [ip=10.11.12.13]
    
    Services:
    +--------------------------------+---------+
    |            service             |  status |
    +--------------------------------+---------+
    | InfluxDB                       | running |
    | Celery Management              | running |
    | Logstash                       | running |
    | RabbitMQ                       | running |
    | AMQP InfluxDB                  | running |
    | Manager Rest-Service           | running |
    | Cloudify UI                    | running |
    | Webserver                      | running |
    | Riemann                        | running |
    | Elasticsearch                  | running |
    +--------------------------------+---------+

Note that this whole procedure only needs to be done once. All subsequent sessions of
playing with Cloudify only require virtual environment activation and variable
export. So we only need to execute

    cd ~/cloudify-mini-examples
    . venv/bin/activate
    export CLOUDIFY_USERNAME=admin
    export CLOUDIFY_PASSWORD=pass

Great, now we are ready to deploy out blueprints.


## Deploying blueprint

To make deploying blueprint a bit easier, we provided a `deploy.sh` bash
script that knows how to deploy a blueprint. For example, to deploy
`bundled-resources` blueprint, execute

    ./deploy bundled-resources

For more information about what this script does, consult the sources.


## Deleting deployment

We also provided a script to execute deployment tear-down called `delete.sh`.
Usage is quite similar to the `deploy.sh` script. Executing

    ./delete.sh bundled-resources

will remove all traces of `bundled-resources` blueprint from manager. Again,
for more information on what this script does, consult the sources.


# Blueprints

Each blueprint in this repository is stored in its own subfolder. We try to
use self-explanatory names for them, but just for the sake of completeness,
here is a list of blueprints with short descriptions of what part of Cloudify
functionality are they trying to demonstrate.

 1. **bundled-resources**: Demonstrates how to download and use resources that
    are bundled with blueprint.
