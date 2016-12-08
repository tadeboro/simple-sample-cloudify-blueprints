#!/bin/bash

set -e

function usage()
{
  cat <<EOF >&2
Error: $1

Usage:
  $0 <blueprint>
EOF

  exit 1
}

[[ $# -lt 1 ]] && usage "Missing blueprint argument."
[[ ! -d $1 ]] && usage "Blueprint '$1' not present on disk."
cfy blueprints get -b $1 > /dev/null \
  && usage "Blueprint '$1' already exists on manager."

# This is here just in case (if blueprint folder is not visible to others,
# Cloudify Manager will have troubles accessing contents).
chmod -R 755 $1

# Package blueprint
rm -f ${1}.tar.gz
tar -cvzf ${1}.tar.gz $1

# Deploy blueprint
cfy blueprints publish-archive -l ${1}.tar.gz -b $1
cfy deployments create -b $1 -d $1
cfy executions start -w install -d $1 -l
