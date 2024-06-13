#!/bin/bash

# Define a function to extract and output a dependency value
get_repository_tag() {
  local file="$1"
  local repo_name="$2"
  local app="$3"

  local version=$(awk -F'"' -v app="$app" '$0 ~ app {print $4}' "$file")
  local ref="refs/tags/v$version"

  # Check if the version number contains "pre" and modify the ref to main branch
  if [[ $version == *"pre"* || $version == *"next"* ]]; then
    ref="main"
  fi

  echo "$repo_name=$ref"
}

spa_assemble_config_file_path="$1"

# Call the function for each Repository with the app as the second argument
get_repository_tag "$spa_assemble_config_file_path" "patient_management" "@openmrs/esm-patient-registration-app" >> "$GITHUB_OUTPUT"
get_repository_tag "$spa_assemble_config_file_path" "patient_chart" "@openmrs/esm-patient-chart-app" >> "$GITHUB_OUTPUT"
get_repository_tag "$spa_assemble_config_file_path" "form_builder" "@openmrs/esm-form-builder-app" >> "$GITHUB_OUTPUT"
get_repository_tag "$spa_assemble_config_file_path" "esm_core" "@openmrs/esm-login-app" >> "$GITHUB_OUTPUT"
