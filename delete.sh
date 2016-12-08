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
  || usage "Blueprint '$1' does not exist on manager."

cfy executions start -w uninstall -d $1 -l
cfy deployments delete -d $1
cfy blueprints delete -b $1
