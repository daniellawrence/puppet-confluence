
# DONT USE THIS YET - NOT READY MASTER!!!

# puppet-confluence
Puppet module authored by Bryce Johnson

## Introduction

puppet-confluence is a module for Atlassian's Collaboration Tool

## Requirements

### Operating System
* MacOS: UNSUPPORTED
* Linux:  RedHat, Debian (& Ubuntu)
* Windows:  UNSUPPORTED
### Databases
* Postgres
* MySQL

### Package Requirements

* Puppet 2.7.x

* hiera and hiera-puppet
This puppet module heavily uses hiera-puppet to decouple configuration 
information from the module itself.  An example is given in confluence.yaml
that you can use to construct your own confluence hieradata information.  Params.pp
is still used since some resource types can't call hiera directly, like file.

* git 1.7.6+ (this module doesn't check, at least yet, just make sure git
is installed)

* open JDK 1.6 (Don't use 1.7 yet), prefer update 33+

### Before you begin
It is your responsibility to backup your database.  Especially do so
if you are installing to an existing installation of confluence as this module
is UNTESTED from with an existing install of confluence

You must have your database setup with the account user that the application
will use.  This information needs to be put in the hiera yaml, for example
confluence.yaml, in your hieradata directory.

Make sure you have a JAVA_HOME and appropriate java installed on your machine.
Recommended is JDK 1.6u33

Did I mention if you are upgrading, BACKUP your database first? This module 
makes no warranty on your data, per its license.

### Installation

This puppet module will be downloading the confluence zip, extract it into
/opt/confluence/atlassian-confluence-$version

A service will also be created for you with chkconfig configured to be on
so that confluence will start up automatically on system start.

You will also need to enter in the directory to your confluence-home, which should
also be kept in the hiera yaml, for example confluence.yaml.

Once you have installed the yaml information, then run puppet apply with 
this module included in the modulepath.

*** Fixes and Future Work
Please feel free to raise any issues here for fixes.  I'm happy to fix them
up.  Also feel free to make a pull request for anything so I can hopefully
get it in.

