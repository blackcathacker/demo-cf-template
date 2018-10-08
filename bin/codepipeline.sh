#!/bin/bash -e

# Load GITHUB_TOKEN and NPM_TOKEN from .env file
eval $(cat .env | sed 's/^/export /')

if (( $# != 1 )); then
  echo "Parameter missing"
  echo "Usage: sh <create or update>"
  echo "e.g. ./codepipeline.sh update"
  exit 1
fi

COMMAND=$1

STACK_NAME="$GITHUBREPO-infrastructure-pipeline-v$VERSION-cf"
echo "Creating ${STACK_NAME}"

aws cloudformation $COMMAND-stack \
  --region us-west-2 \
  --stack-name $STACK_NAME \
  --template-body file://templates/infrastructure-pipeline.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameters \
    ParameterKey=Version,ParameterValue=$VERSION \
    ParameterKey=GitHubRepo,ParameterValue=$GITHUBREPO \
    ParameterKey=GitHubOAuthToken,ParameterValue=$GITHUB_TOKEN

aws cloudformation wait stack-$COMMAND-complete \
  --region us-west-2 \
  --stack-name $STACK_NAME && \
aws cloudformation describe-stacks \
  --region us-west-2 \
  --stack-name $STACK_NAME \
  --output table \
  --query Stacks[0].Outputs
