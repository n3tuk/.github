#! /usr/bin/env bash

set -euo pipefail

# Bind variables from the environment before use
CI=${CI:-false}
DEBUG=${DEBUG:-}

# Set up colours for improving output
DIM='\033[2m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
WHITE='\033[0;37m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check to see if the variable name provided both exists and has a value
# associated with it, otherwise error and exit the script
function check_variables {
  for variable in "${@}"; do
    check_variable "${variable}"
  done
}
# Check to see if the variable name provided both exists and has a value
# associated with it, otherwise error and exit the script
function check_variable {
  set +u # Don't error out on unbound variables in this function
  if [[ -z "${!1}" ]]; then
    exit_error "Missing the environment variable '${1}'"
  fi
  set -u
  show_debug "\$${1} = '${!1}'"
}

# Check to see if all the commands provided exists and are executable, otherwise
# error and exit the script
function check_commands {
  for command in "${@}"; do
    check_command "${command}"
  done
}

# Check to see if the command provided both exists and is executable, otherwise
# error and exit the script
function check_command {
  if [[ ! -x "$(command -v "${1}")" ]]; then
    exit_error "Missing the ${1} application. Please install and try again."
  fi
  show_debug "${1} = '$(command -v "${1}")'"
}

# Initiate the starting of a grouped output for GitHub Actions
function start_group {
  if [[ "${CI}" == "true" ]]; then
    echo >&2 "::group::${1}"
  fi
  show_stage "${1}"
}

# End the grouped output section for GitHub Actions
function end_group {
  if [[ "${CI}" == "true" ]]; then
    echo >&2 "::endgroup::"
  fi
}

# Output a debug message for GitHub Actions
function show_debug {
  if [[ "${CI}" == "true" ]]; then
    echo >&2 "::debug::${*}"
  elif [[ -n "${DEBUG}" ]]; then
    echo >&2 -e "${DIM}DEBUG: ${*}${NC}"
  fi
}

# Output the header for a new stage in the application
function show_stage {
  echo -e "${YELLOW}==>${NC} ${WHITE}${1}${NC}"
}

# Output the message for a step in the application
function show_step {
  echo -e " ${BLUE}->${NC} ${WHITE}${1}${NC}"
}

# Append a directory to PATH for GitHub Workflows
function add_path {
  show_debug "\$PATH += \"${1}\" >> ${GITHUB_PATH:-/dev/null}"
  echo "${1}" >>"${GITHUB_PATH:-/dev/null}"
}

# Define an output in the GitHub Action for GitHub Workflows
function put_output {
  show_debug "${1}=\"${2}\" >> ${GITHUB_OUTPUT:-/dev/null}"
  echo "${1}=\"${2}\"" >>"${GITHUB_OUTPUT:-/dev/null}"
}

# Output an error message for GitHub Actions
function show_error {
  local title=${1}
  shift

  if [[ "${CI}" == "true" ]]; then
    echo >&2 "::error title=${title}::${*}"
  else
    echo >&2 -e "${RED}ERROR${NC}: ${RED}${title}{$NC} (${*})"
  fi
}

# Output an error message for GitHub Actions and then immediately exit the
# script
function exit_error {
  show_error "${*}"
  exit 1
}
