#!/bin/bash
# Purpose : To list down all the instances running across regions in AWS
# Authon : Karthikeyan Sundharrajan ( email : karthik120@gmail.com )
for region in `aws ec2 describe-regions --output text | cut -f3`
do
     echo -e "\nListing Instances in region:'$region'..."
     aws ec2 describe-instances --filters  "Name=instance-state-name,Values=running" --region $region | jq --compact-output '.Reservations[] | ( .Instances[] | {instanceid: .InstanceId,type: .InstanceType, state: .State.Name})'
done
 
