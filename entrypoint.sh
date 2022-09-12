#!/bin/bash -l

function printDelimeter {
  echo "----------------------------------------------------------------------"
}

function printLargeDelimeter {
  echo -e "\n\n------------------------------------------------------------------------------------------\n\n"
}

function printStepExecutionDelimeter {
  echo "----------------------------------------"
}

function displayInfo {
  echo
  printDelimeter
  echo
  HELM_CHECK_VERSION="v0.2.1"
  HELM_CHECK_SOURCES="https://github.com/ZSuiteTech/helm-check-action"
  echo "Helm-Check $HELM_CHECK_VERSION"
  echo -e "Source code: $HELM_CHECK_SOURCES"
  echo
  printDelimeter
}

function helmTemplate {
  printLargeDelimeter
  echo -e "2. Trying to render templates with provided values\n"
  if [[ "$3" -eq 0 ]]; then
    if [ -n "$2" ]; then
      echo "helm template --values $2 $1"
      printStepExecutionDelimeter
      helm template --values $2 "$1"
      HELM_TEMPLATE_EXIT_CODE=$?
      printStepExecutionDelimeter
      if [ $HELM_TEMPLATE_EXIT_CODE -eq 0 ]; then
        echo "Result: SUCCESS"
      else
        echo "Result: FAILED"
      fi
      return $HELM_TEMPLATE_EXIT_CODE
    else
      printStepExecutionDelimeter
      echo "Skipped due to condition: values are not provided"
      printStepExecutionDelimeter
    fi
  else
    echo "Skipped due to failure: Previous step has failed"
    return $3
  fi
  return 0
}

function totalInfo {
  printLargeDelimeter
  echo -e "3. Summary\n"
  if [[ "$1" -eq 0 ]]; then
    echo "Examination is completed; no errors found!"
    exit 0
  else
    echo "Examination is completed; errors found, check the log for details!"
    exit 1
  fi
}

displayInfo
helmTemplate $1 $2
totalInfo $?
