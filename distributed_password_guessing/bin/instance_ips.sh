#!/bin/bash

if ! which aws > /dev/null; then
  echo "You must first install the aws cli"
  exit 1
fi

REGION=us-west-2
GROUP_NAME=DistributedPasswordGuessingScenario
INSTANCE_IDS=$(aws --region $REGION autoscaling describe-auto-scaling-groups --auto-scaling-group-names $GROUP_NAME | jq -r '.AutoScalingGroups[0].Instances[]|.InstanceId')

for i in $INSTANCE_IDS; do
  aws --region $REGION ec2 describe-instances --instance-ids $i | jq -r '.Reservations[0].Instances[0]|.PublicIpAddress'
done
