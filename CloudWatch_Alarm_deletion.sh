#!/bin/bash
# Script to delete all the alarms in Cloudwatch. Set approprite region in .aws/config file before executing this file
# Authon : Karthikeyan Sundharrajan ( email: karthik120@gmail.com )
region=`cat .aws/config | grep region | cut -c 10-`
aws cloudwatch describe-alarms > us_${region}_alarms.json
cat us_${region}_alarms.json | jq --compact-output '.MetricAlarms[] | {Alarmname: .AlarmName}' | cut -c 15- | sed 's/.\{2\}$//' > US_${region}_Alarms.txt
file=US_${region}_Alarms.txt
while IFS= read -r line
do
  aws cloudwatch delete-alarms --alarm-names `echo $line`
done <"$file"
