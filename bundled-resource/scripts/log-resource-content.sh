#!/bin/bash

function main()
{
  local resource_path, local_resource_path

  ctx logger info "Downloading resource, set in node property ..."
  resource_path=$(ctx node properties "resource")
  local_resource_path=$(ctx download-resource "$resource_path")
  ctx logger info "Resource downloaded to ${local_resource_path}."
  ctx logger info "Resource content: $(cat $local_resource_path)"

  ctx logger info "Downloading resource not referenced by blueprint ..."
  local_resource_path=$(ctx download-resource "resources/res-3.txt")
  ctx logger info "Resource downloaded to ${local_resource_path}."
  ctx logger info "Resource content: $(cat $local_resource_path)"
}

main
