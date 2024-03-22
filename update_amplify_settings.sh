#!/bin/bash

# Set your AWS region and Amplify app ID
AWS_REGION="us-east-2" # Replace with your actual AWS region
AMPLIFY_APP_ID="d2a8h6q8ja4u04" # Replace with the actual App ID for demoApp

# Run the curl command and capture the status code
STATUS=$(curl -s -o /dev/null -w "%{http_code}" 'https://incorrect-url.example.com/dev2/getJobListBasic' \
 -H 'Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hdHR1LmdAc2tpbGxyYW5rLmlvIiwiaWF0IjoxNzEwNzYwMDY0LCJleHAiOjE3MTMzNTIwNjR9.qEh3KfvULrBuZ6p5wCcuSisNOeltIVKg-s3WGQfbHdM' \
 -H 'Content-Type: application/json' \
 --data-raw '{"employerId":"65f8207adf6e36206564563f"}')

# Check the status code and set the AMPLIFY_DIFF_DEPLOY environment variable accordingly
if [ "$STATUS" -eq 200 ]; then
 echo "Backend deployment successful, enabling diff-based frontend build and deploy."
 aws amplify update-app --app-id $AMPLIFY_APP_ID --region $AWS_REGION --environment-variables AMPLIFY_DIFF_DEPLOY=true
else
 echo "Backend deployment failed, disabling diff-based frontend build and deploy."
 aws amplify update-app --app-id $AMPLIFY_APP_ID --region $AWS_REGION --environment-variables AMPLIFY_DIFF_DEPLOY=false
fi