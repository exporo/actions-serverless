#!/bin/sh -l

echo "Stage $1"
echo "Profile: $2"
echo "Region: $3"
echo "Command: $6"

mkdir ~/.aws
printf "[$2]\naws_access_key_id = $4\naws_secret_access_key = $5" >> ~/.aws/credentials
printf "[$2]\nregion = $3" >> ~/.aws/config
cat ~/.aws/config
printf  "\n"
cat ~/.aws/credentials
printf "\n"

serverless $6 --stage $1 --aws-profile $2
