#!/bin/bash
# This script is used to start then poll the status of jenkins jobs and output the log at the end.
# Currently this is used to trigger jenkins to push shas to docker then run rancher deploys
# assumes environment vars
# JENKINS_TOKEN
# JENKINS_USER
# JENKINS_PASSWORD
# JENKINS_JOB


cred_file=$(find "${HOME}" -name 'jenkins_credentials.dec' | head -n 1)

if [ -z "${cred_file}" ] || [ ! -f "${cred_file}" ]; then
  echo "Unable to find jenkins credentials file"
  exit 1
else
  # shellcheck disable=SC1090
  source "${cred_file}"
fi

if [ -z "$JENKINS_USER"  ] || [ -z "$JENKINS_TOKEN"  ] || [ -z "$JENKINS_PASSWORD" ]; then
  echo "Unable to read jenkins secrets"
  exit 1
fi


#number of seconds to wait for deployment
TIMEOUT=600
#number of seconds to wait between status checks
SLEEP=1

JENKINS_URL=https://${JENKINS_USER}:${JENKINS_PASSWORD}@jenkins.weedmaps.com/job/${JENKINS_JOB}
JENKINS_ENVIRONMENT_COMPOSE_FILE= : ${JENKINS_ENVIRONMENT_COMPOSE_FILE:=docker-compose.rancher.yml}

# This is used to instantiate the build_docker_shas job
function build_docker_shas() {
  echo "Starting task"
  echo "Params:
  revision:${BRANCH}:${SHA}
  repository:${REPOSITORY}"
  # shellcheck disable=SC1001
  QUEUE_URL=$(curl -s -I -XPOST "${JENKINS_URL}/buildWithParameters?token=${JENKINS_TOKEN}&branch=${BRANCH}&repository=${REPOSITORY}&sha=${SHA}&environment_compose_file=${JENKINS_ENVIRONMENT_COMPOSE_FILE}" |grep Location |cut -d " " -f2 |cut -d \/ -f3-6)
  if [ -z "$QUEUE_URL" ]; then
    echo "Unable to start job"
    exit 1
  fi
  echo "Waiting for job to start"
  sleep 10
  get_jenkins_build_id
  poll_job_status
}

# This is used to instantiate the rancher_deploy job
function rancher_deploy() {
  echo "Starting task"
  echo "Params:
  revision:${BRANCH}:${SHA}
  repository:${REPOSITORY}
  deploy_env:${DEPLOY_ENVIRONMENT}
  application_env:${APPLICATION_ENVIRONMENT}"
  # shellcheck disable=1001
  QUEUE_URL=$(curl -s -I -XPOST "${JENKINS_URL}/buildWithParameters?token=${JENKINS_TOKEN}&branch=${BRANCH}&repository=${REPOSITORY}&deploy_label=${DEPLOY_LABEL}&environment_compose_file=${JENKINS_ENVIRONMENT_COMPOSE_FILE}&deploy_environment=${DEPLOY_ENVIRONMENT}&application_environment=${APPLICATION_ENVIRONMENT}&sha=${SHA}" |grep Location |cut -d " " -f2 |cut -d \/ -f3-6)
  if [ -z "$QUEUE_URL" ]; then
    echo "Unable to start job"
    exit 1
  fi
  echo "Waiting for job to start"
  sleep 10
  get_jenkins_build_id
  poll_job_status
}

# This is used to instantiate the deploy_api job
function deploy_api() {
  echo "Starting task"
  echo "Params:
  env:${DEPLOY_ENVIRONMENT}
  api_version:${sha}"

  QUEUE_URL=$(curl -s -I -XPOST "${JENKINS_URL}/buildWithParameters?api_version=${SHA}&env=${DEPLOY_ENVIRONMENT}" |grep Location |cut -d " " -f2 |cut -d \/ -f3-6)
  # shellcheck disable=1001
  if [ -z "$QUEUE_URL" ]; then
    echo "Unable to start job"
    exit 1
  fi
  echo "Waiting for job to start"
  sleep 10
  get_jenkins_build_id
  poll_job_status
}

function get_jenkins_build_id() {
  JENKINS_BUILD_ID=$(curl -s https://"${JENKINS_USER}":"${JENKINS_PASSWORD}"@"${QUEUE_URL}"/api/json |jq .executable.number)
  if [ "$JENKINS_BUILD_ID" ]; then
    echo "Found build id ${JENKINS_BUILD_ID}"
  else
    echo "Unable to find jenkins build id"
    exit 1
  fi
}

function get_console_output() {
  curl "$JENKINS_URL"/"${JENKINS_BUILD_ID}"/consoleText
  return_exit
}

function poll_job_status() {
  RESULT=$(curl -s "$JENKINS_URL"/"${JENKINS_BUILD_ID}"/api/json?pretty=true |jq .result)
  TIME=0
  echo "Polling jenkins"
  if [ -z "$RESULT" ]; then
    echo "Unable to get Response from jenkins"
    exit 1
  fi
  while [ "$RESULT" == 'null' ] && [ $TIME -lt $TIMEOUT ]; do
    echo -ne .${TIME}
    sleep $SLEEP
    TIME=$((TIME + 1))
    RESULT=$(curl -s "$JENKINS_URL"/"${JENKINS_BUILD_ID}"/api/json?pretty=true |jq .result)
  done
  echo -e "\nJob finished with status ${RESULT}"
  get_console_output
}

function return_exit() {
  if [[ ! ${RESULT} =~ "SUCCESS" ]]; then
    exit 1
  fi
}


case "$JENKINS_JOB" in

build_docker_images)  build_docker_shas
    ;;
build_efs_backup)  build_docker_shas
    ;;
rancher_deploy)  rancher_deploy
    ;;
deploy_api)  deploy_api
    ;;
*) echo "${JENKINS_JOB} does not have an action"
   ;;
esac
