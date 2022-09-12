# Description [![Version](https://img.shields.io/badge/version-0.2.0-color.svg)](https://github.com/igabaydulin/helm-check-action/releases/tag/0.2.0)

helm-check is a [github action](https://github.com/features/actions) tool which allows to prevalidate helm chart
template before its deployment; executes [helm template](https://helm.sh/docs/helm/#helm-template)
command and confirms it compiles based on the provided value(s) files.

## Table of Contents
  - [Components](#components)
  - [Environment variables](#environment-variables)
  - [Example Check](#example-check)
  - [Testing](#testing)

## Components
* `Dockerfile`: contains docker image configuration
* `entrypoint.sh`: contains executable script for helm templates validation

## Environment variables
* `CHART_LOCATION`: chart folder; required field for  `helm template` execution
* `CHART_VALUES`: custom values file for specific kubernetes environment; required field for `helm template` execution. Can daisy chain multiple files by addind ` -f value.yaml` after the initial yaml file. EX: `values.yaml -f some.yaml -f other.yaml`

## Example Check
```
name: Template Check

on:
  pull_request:
    branches: [ main ]
  workflow_dispatch:

jobs:
  template-check:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
      - name: helm-check
        uses: ZSuiteTech/helm-check-action@0.2.1
        env:
          CHART_LOCATION: ./dir
          CHART_VALUES: ./dir/dev.values.yaml -f ./dir/beta-dev.values.yaml
```

## Testing
You can test script locally, but make sure you have all needed tools (helm at least); next steps describe how 
to test action on Linux system:

1. Clone action repository
1. Make sure entrypoint.sh is executable, otherwise execute next command in terminal:

    ```
    user@localhost:~/dev/helm-check-action$ chmod +x ./entrypoint.sh
    ```
1. Move to your repository and execute next command in terminal:

    ```
    user@localhost:~/dev/my-local-repository$ /path/to/entrypoint.sh /path/to/chart "/path/to/values/values.yaml" 
    ```
    or 
     ```
    user@localhost:~/dev/my-local-repository$ /path/to/entrypoint.sh /path/to/chart "/path/to/values/values.yaml -f /path/to/some/other/values.yaml" 
    ```

